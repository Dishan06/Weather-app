// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:weather_app/screens/favoriteCitiesProvider.dart';
import 'package:weather_app/screens/homePage.dart';
import 'dart:convert';

import 'package:weather_app/screens/weatherDetailsPage.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => FavoriteCitiesProvider(),
//       child: App(),
//     ),
//   );
// }
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoriteCitiesProvider(),
      child: App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      // home: WeatherApp(),
      home: HomePage(),
    );
  }
}
