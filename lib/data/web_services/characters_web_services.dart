import 'dart:convert';

import 'package:bloc_app/data/model/characters.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class characters_web_services with ChangeNotifier {
  late Dio dio;

  characters_web_services() {
    BaseOptions options = BaseOptions(
      baseUrl: "https://www.breakingbadapi.com/api/",
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 60 second
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
  List<characters> allcharacters = [];

  Future<void> fetchdata() async {
    Response res = await dio.get("characters");
    if (res.statusCode == 200) {
      print(res.data.toString());
    } else {
      print("error");
    }
    var decodeddata = res.data;
    final finaldata =
        decodeddata.map((item) => characters.fromJson(item)).toList();
    List<characters> loadedcharacters = [];
    for (var item in finaldata) {
      loadedcharacters.add(characters(
        name: item.name,
        nickname: item.nickname,
        charId: item.charId,
        birthday: item.birthday,
        occupation: item.occupation,
        img: item.img,
        status: item.status,
        appearance: item.appearance,
        portrayed: item.portrayed,
        category: item.category,
      ));
    }
    allcharacters = loadedcharacters;
    print(finaldata);
    notifyListeners();
  }
}
