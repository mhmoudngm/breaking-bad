import 'dart:convert';

import 'package:bloc_app/data/model/characters.dart';
import 'package:bloc_app/data/web_services/characters_web_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class characters_screen extends StatefulWidget {
  @override
  State<characters_screen> createState() => _characters_screenState();
}

class _characters_screenState extends State<characters_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // Provider.of<characters_web_services>(context, listen: false).fetchdata();
  }

  List searchedlist = [];
  late List<characters> allcharacters =
      Provider.of<characters_web_services>(context, listen: false).allcharacters
          as List<characters>;
  bool issearched = false;
  var searchtextcontroller = TextEditingController();

  Widget buildsearchfield() {
    return TextField(
      textAlign: TextAlign.left,
      controller: searchtextcontroller,
      cursorColor: Colors.grey,
      decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Find a Characters ",
          hintStyle: TextStyle(fontSize: 18, color: Colors.black38)),
      style: TextStyle(fontSize: 18, color: Colors.black38),
      onChanged: (searchtextcontroller) {
        addsearcheditemtosearchedlist(searchtextcontroller);
      },
    );
  }

  void addsearcheditemtosearchedlist(String serachedcharacter) {
    searchedlist = allcharacters
        .where(
            (chara) => chara.name.toLowerCase().startsWith(serachedcharacter))
        .toList();
    setState(() {
      issearched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: !issearched
            ? AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          issearched = true;
                        });
                      },
                      icon: Icon(Icons.search_rounded))
                ],
                backgroundColor: Colors.yellow,
                title: Text(
                  "Characters",
                  style: TextStyle(color: Colors.black38),
                ),
              )
            : AppBar(
                backgroundColor: Colors.yellow,
                leading: IconButton(
                    onPressed: () {
                      setState(() {
                        issearched = false;
                      });
                    },
                    icon: Icon(Icons.arrow_back)),
                title: buildsearchfield(),
                actions: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          searchtextcontroller.clear();
                        });
                      },
                      icon: Icon(Icons.clear))
                ],
              ),
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return Center(
                child: FutureBuilder(
                  future: Provider.of<characters_web_services>(context,
                          listen: false)
                      .fetchdata(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.yellow,
                      ));
                    } else {
                      return Consumer<characters_web_services>(
                          builder: (context, value, _) => Container(
                                color: Colors.grey,
                                padding: EdgeInsets.all(8),
                                child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 2 / 3,
                                      mainAxisSpacing: 10,
                                    ),
                                    itemCount: issearched
                                        ? searchedlist.length
                                        : value.allcharacters.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: !issearched
                                            ? GestureDetector(
                                                onTap: () =>
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            "/cds",
                                                            arguments: {
                                                          "index": index
                                                        }),
                                                child: GridTile(
                                                  child: Hero(
                                                      tag: index,
                                                      child: Container(
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: FadeInImage(
                                                              fit: BoxFit.cover,
                                                              placeholder:
                                                                  const AssetImage(
                                                                      "assets/images/loading.gif"),
                                                              image:
                                                                  NetworkImage(
                                                                value
                                                                    .allcharacters[
                                                                        index]
                                                                    .img,
                                                              )))),
                                                  footer: Container(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    width: double.infinity,
                                                    color: Colors.black54,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 15),
                                                    child: Text(
                                                      value.allcharacters[index]
                                                          .name,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          height: 1.3,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ))
                                            : GestureDetector(
                                                onTap: () =>
                                                    Navigator.pushNamed(
                                                        context, "/cds",
                                                        arguments: {
                                                      "index": index
                                                    }),
                                                child: GridTile(
                                                  child: Hero(
                                                      tag: index,
                                                      child: Container(
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: FadeInImage(
                                                              fit: BoxFit.cover,
                                                              placeholder:
                                                                  const AssetImage(
                                                                      "assets/images/loading.gif"),
                                                              image:
                                                                  NetworkImage(
                                                                searchedlist[
                                                                        index]
                                                                    .img,
                                                              )))),
                                                  footer: Container(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    width: double.infinity,
                                                    color: Colors.black54,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 15),
                                                    child: Text(
                                                      searchedlist[index].name,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          height: 1.3,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      );
                                    }),
                              ));
                    }
                  },
                ),
              );
            } 
            else {
              return Center(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child:ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          "assets/images/n.jpg",
                          fit: BoxFit.fill,
                        ),
                      ),
                ),
              );
            }
          },
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
