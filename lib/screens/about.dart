// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app/screens/favoriteCities.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.black : Colors.white,
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.01,
                        horizontal: size.width * 0.05,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => {
                              Navigator.pop(context),
                            },
                            child: FaIcon(
                              FontAwesomeIcons.arrowLeft,
                              color:
                                  isDarkMode ? Colors.white : Colors.blueGrey,
                              size: 20,
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  'Weather App',
                                  style: GoogleFonts.adventPro(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.blueGrey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 55, bottom: 25, left: 45),
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.phone,
                            color: isDarkMode ? Colors.white : Colors.blueGrey,
                            size: 20,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          GestureDetector(
                            onTap: () {
                              launch('tel:+94771234567');
                            },
                            child: Text(
                              '+94 77 123 4567',
                              style: GoogleFonts.adventPro(
                                decoration: TextDecoration.underline,
                                color:
                                    isDarkMode ? Colors.white : Colors.blueGrey,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 25, left: 42),
                      child: Row(
                        children: [
                          Icon(
                            Icons.email,
                            color: isDarkMode ? Colors.white : Colors.blueGrey,
                            size: 25,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          GestureDetector(
                            onTap: () {
                              launch(
                                  'mailto:example@example.com'); // Replace with the desired email address
                            },
                            child: Text(
                              'mjs@weatherapp.com',
                              style: GoogleFonts.adventPro(
                                color:
                                    isDarkMode ? Colors.white : Colors.blueGrey,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20, left: 45),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.locationDot,
                            color: isDarkMode ? Colors.white : Colors.blueGrey,
                            size: 20,
                          ),
                          SizedBox(
                            width: 31,
                          ),
                          Text(
                            "3/2, Moon Lane, H-way",
                            style: GoogleFonts.adventPro(
                              color:
                                  isDarkMode ? Colors.white : Colors.blueGrey,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    color: isDarkMode ? Colors.black : Colors.white,
                    child: Text(
                      'openweathermap\n© 2023 WeatherApp. All rights reserved.',
                      style: GoogleFonts.adventPro(
                          fontSize: 15,
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
