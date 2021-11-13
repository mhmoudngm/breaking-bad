import 'package:bloc_app/presentation/screens/characters_details_screen.dart';
import 'package:bloc_app/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/web_services/characters_web_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<characters_web_services>(
      create:(context)=>characters_web_services(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => characters_screen(),
          '/cds' :(context) => characters_details_screen(),
        },
      ),
    );
  }
}

