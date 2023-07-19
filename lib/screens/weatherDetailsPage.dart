// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:weather_app/screens/favoriteCities.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/homePage.dart';

import 'city.dart';
import 'favoriteCitiesProvider.dart';

class WeatherApp extends StatefulWidget {
  final String cityName;

  WeatherApp({required this.cityName});

  // const WeatherApp({Key? key}) : super(key: key);

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String city = 'Colombo';
  String apiKey = '4711c091576ce52189f63952bffbe2fa';

  String temperature = '';
  String feelsLike = '';
  String minTemp = '';
  String maxTemp = '';
  String description = '';
  String errorMessage = '';

  String searchValue = '';
  bool loading = false;
  bool favorite = false;
  bool isSearch = false;
  bool isRefreshing = false;
  bool startLoading = true;

  String pressure = '';
  String humidity = '';
  String seaLevel = '';
  String visibility = '';
  String windSpeed = '';

  final textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    city = widget.cityName;
    getWeather();
  }

  void getWeather() async {
    String url =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        double temp = data['main']['temp'];
        double feels = data['main']['feels_like'];
        double min = data['main']['temp_min'];
        double max = data['main']['temp_max'];
        String desc = data['weather'][0]['description'];

        setState(() {
          temperature = (temp - 273.15).toStringAsFixed(1);
          feelsLike = (feels - 273.15).toStringAsFixed(1);
          minTemp = (min - 273.15).toStringAsFixed(1);
          maxTemp = (max - 273.15).toStringAsFixed(1);
          pressure = data['main']['pressure'].toString();
          humidity = data['main']['humidity'].toString();
          seaLevel = data['main']['sea_level'].toString();
          visibility = (data['visibility'] * 0.001).toString();
          windSpeed = data['wind']['speed'].toString();
          description = desc;
          city = data['name'];
          errorMessage = '';
          startLoading = false;
        });
      } else {
        setState(() {
          temperature = '';
          feelsLike = '';
          minTemp = '';
          maxTemp = '';
          pressure = '';
          humidity = "";
          seaLevel = "";
          visibility = "";
          windSpeed = "";
          description = '';
          errorMessage =
              'Error retrieving weather data\nPlease try again later!';
        });
      }
    } catch (e) {
      setState(() {
        temperature = 'a';
        feelsLike = '';
        minTemp = '';
        maxTemp = '';
        pressure = '';
        humidity = "";
        seaLevel = "";
        visibility = "";
        windSpeed = "";
        description = '';
        errorMessage = 'Error retrieving weather data\nPlease try again later!';
      });
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void hideKeyboard() {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.requestFocus(FocusNode());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    double temperatureValue;
    try {
      temperatureValue = double.parse(temperature);
    } catch (e) {
      print('Error parsing temperature: $e');
      temperatureValue = 26.0;
    }
    return Consumer<FavoriteCitiesProvider>(
      builder: (context, favoriteCitiesProvider, child) {
        // ignore: iterable_contains_unrelated_type
        // final isFavorite = favoriteCitiesProvider.favoriteCities
        //     .any((element) => element[0] == city);

        final isFavorite = favoriteCitiesProvider.favoriteCities.any((list) =>
            list.name ==
            city); //favoriteCitiesProvider.favoriteCities.contains(city);
        favorite = isFavorite;
        return Scaffold(
          body: Center(
            child: GestureDetector(
              onTap: () {
                hideKeyboard();
              },
              child: Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.black : Colors.white,
                ),
                child: SafeArea(
                  child: Stack(
                    children: [
                      Container(
                          height: size.height,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: temperatureValue > 25.0
                                  ? AssetImage("assets/images/sunny.jpeg")
                                  : AssetImage("assets/images/rainy.jpeg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  color: isDarkMode
                                      ? Colors.transparent
                                      : Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: size.height * 0.02,
                                      horizontal: size.width * 0.05,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () => {
                                            // Navigator.pop(context),
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage(),
                                              ),
                                            )
                                          },
                                          child: FaIcon(
                                            FontAwesomeIcons.home,
                                            color: isDarkMode
                                                ? Colors.white
                                                : Colors.blueGrey,
                                            size: 20,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: size.width * 0.05),
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
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              favorite = !favorite;
                                            });
                                            final favoriteCitiesProvider =
                                                Provider.of<
                                                        FavoriteCitiesProvider>(
                                                    context,
                                                    listen: false);

                                            if (favorite) {
                                              favoriteCitiesProvider
                                                  .addFavoriteCity(City(
                                                      name: city,
                                                      isFavorite: true));
                                            } else {
                                              favoriteCitiesProvider
                                                  .removeFavoriteCity(City(
                                                      name: city,
                                                      isFavorite: false));
                                            }
                                          },
                                          child: Icon(
                                            favorite
                                                ? Icons.star
                                                : Icons.star_border,
                                            color: isDarkMode
                                                ? favorite
                                                    ? Colors.amber
                                                    : Colors.white
                                                : favorite
                                                    ? Colors.amber
                                                    : Colors.blueGrey,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (temperature != '' && !loading)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 20, right: 45),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() async {
                                            isRefreshing = true;
                                            getWeather();
                                            await Future.delayed(
                                                Duration(seconds: 1));
                                            isRefreshing = false;
                                            print(isRefreshing);
                                          });
                                        },
                                        child: AnimatedSwitcher(
                                          duration: Duration(milliseconds: 300),
                                          transitionBuilder:
                                              (child, animation) {
                                            return RotationTransition(
                                              turns: animation,
                                              child: child,
                                            );
                                          },
                                          child: Icon(
                                            Icons.refresh,
                                            key: ValueKey<bool>(isRefreshing),
                                            color: isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (temperature != '' && !loading)
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 5,
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(left: 40),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: temperature,
                                              style: GoogleFonts.adventPro(
                                                  fontSize: 85,
                                                  color: isDarkMode
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            WidgetSpan(
                                              child: Transform.translate(
                                                offset: const Offset(0, -35),
                                                child: Text(
                                                  '°C',
                                                  style: GoogleFonts.adventPro(
                                                      fontSize: 35,
                                                      color: isDarkMode
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                if (minTemp != '' && maxTemp != '' && !loading)
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 5,
                                    ),
                                    child: Align(
                                      child: Text(
                                        '$minTemp~$maxTemp°C',
                                        style: GoogleFonts.adventPro(
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (feelsLike != '' && !loading)
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 5,
                                    ),
                                    child: Align(
                                      child: Text(
                                        'feels like $feelsLike°C',
                                        style: GoogleFonts.cutive(
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (description != '' && !loading)
                                  Padding(
                                    padding: EdgeInsets.only(top: 0, bottom: 5),
                                    child: Align(
                                      child: Text(
                                        description,
                                        style: GoogleFonts.adventPro(
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (temperature != '' && !loading)
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 15,
                                    ),
                                    child: Align(
                                      child: Text(
                                        city,
                                        style: GoogleFonts.cutive(
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 35,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (startLoading && errorMessage == '')
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: size.height * 0.40),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SpinKitCircle(
                                          color: Colors.blueGrey,
                                          size: 75,
                                        ),
                                      ],
                                    ),
                                  ),
                                if (errorMessage != '' && !loading)
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: size.height * 0.25),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.cloudflare,
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.blueGrey,
                                          size: 150,
                                        ),
                                        Text(
                                          errorMessage,
                                          style: GoogleFonts.adventPro(
                                            color: Colors.red,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                SizedBox(height: 25),
                                if (temperature != '' && !loading)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 50),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey[100],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.speed,
                                              color: Colors.black,
                                              size: 50,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              '$pressure hPa',
                                              style: GoogleFonts.adventPro(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'pressure',
                                              style: GoogleFonts.adventPro(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 50, left: 35),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey[100],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.water_drop,
                                              color: Colors.black,
                                              size: 50,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              '$humidity%',
                                              style: GoogleFonts.adventPro(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'humidity',
                                              style: GoogleFonts.adventPro(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                if (temperature != '' && !loading)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 35),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey[100],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.visibility_outlined,
                                              color: Colors.black,
                                              size: 50,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              '$visibility km',
                                              style: GoogleFonts.adventPro(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'visibility',
                                              style: GoogleFonts.adventPro(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 35, left: 20),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey[100],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.air,
                                              color: Colors.black,
                                              size: 50,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              '$windSpeed km/h',
                                              style: GoogleFonts.adventPro(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'wind Speed',
                                              style: GoogleFonts.adventPro(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 35, left: 20),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey[100],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.water,
                                              color: Colors.black,
                                              size: 50,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              '$seaLevel mm',
                                              style: GoogleFonts.adventPro(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'wind Speed',
                                              style: GoogleFonts.adventPro(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                SizedBox(height: 30),
                                //       if (temperature != '' && !loading)
                                //         Container(
                                //           margin: EdgeInsets.symmetric(
                                //               horizontal: size.width * 0.26),
                                //           padding: EdgeInsets.all(2),
                                //           color: isDarkMode ? Colors.black : Colors.white,
                                //           child: Text(
                                //             'openweathermap\n© 2023 WeatherApp. All rights reserved.',
                                //             style: GoogleFonts.adventPro(
                                //               fontSize: 12,
                                //               color: isDarkMode
                                //                   ? Colors.white
                                //                   : Colors.black,
                                //               fontWeight: FontWeight.w500,
                                //             ),
                                //             textAlign: TextAlign.center,
                                //           ),
                                //         ),
                              ],
                            ),
                          )),
                      // if (errorMessage != '' && !loading)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          color: Colors.transparent,
                          child: Text(
                            'openweathermap\n© 2023 WeatherApp. All rights reserved.',
                            style: GoogleFonts.adventPro(
                                fontSize: 12,
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
          ),
        );
      },
    );
  }
}
