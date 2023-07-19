// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/screens/about.dart';
import 'dart:convert';

import 'package:weather_app/screens/favoriteCities.dart';
import 'package:weather_app/screens/searchCity.dart';
import 'package:weather_app/screens/weatherDetailsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String city = 'Colombo';
  String apiKey = '4711c091576ce52189f63952bffbe2fa';

  String temperature = '';
  String feelsLike = '';
  String minTemp = '';
  String maxTemp = '';
  String description = '';
  String errorMessage = '';

  String pressure = '';
  String humidity = '';
  String seaLevel = '';
  String visibility = '';
  String windSpeed = '';

  bool startLoading = true;

  final textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        width: size.width * 0.55,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  'Weather App',
                  style: GoogleFonts.cutive(
                    color: isDarkMode ? Colors.black : Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.star,
                color: Colors.amber,
                size: 30,
              ),
              title: Text(
                'Favorite',
                style: GoogleFonts.cutive(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 15,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteCitiesPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.peopleGroup,
                color: Colors.lightBlueAccent,
                size: 25,
              ),
              title: Text(
                'About',
                style: GoogleFonts.cutive(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 15,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.02,
                        horizontal: size.width * 0.05,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => {
                              _openDrawer(),
                            },
                            child: Icon(
                              Icons.menu,
                              color:
                                  isDarkMode ? Colors.white : Colors.blueGrey,
                              size: 25,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: size.width * 0.05),
                            child: Text(
                              'Weather App',
                              style: GoogleFonts.adventPro(
                                color:
                                    isDarkMode ? Colors.white : Colors.blueGrey,
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchPage(),
                                ),
                              )
                            },
                            child: FaIcon(
                              FontAwesomeIcons.search,
                              color:
                                  isDarkMode ? Colors.white : Colors.blueGrey,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (temperature != '')
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WeatherApp(cityName: city),
                            ),
                          );
                        },
                        child: Container(
                          height: size.height * 0.40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: double.parse(temperature) > 25
                                  ? AssetImage("assets/images/sunny.jpeg")
                                  : AssetImage("assets/images/rainy.jpeg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 55,
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
                                            offset: const Offset(0,
                                                -35), // Adjust the offset to position the superscript
                                            child: Text(
                                              '°C',
                                              style: GoogleFonts.adventPro(
                                                  fontSize: 35,
                                                  color: isDarkMode
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
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
                            ],
                          ),
                        ),
                      ),
                    if (startLoading && errorMessage == '')
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SpinKitCircle(
                              color: Colors.blueGrey,
                              size: 75,
                            ),
                          ],
                        ),
                      ),
                    if (errorMessage != '')
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.25, left: size.width * 0.18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.cloudflare,
                              color:
                                  isDarkMode ? Colors.white : Colors.blueGrey,
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
                    SizedBox(height: size.height * 0.05),
                    if (errorMessage == '' && !startLoading)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      WeatherApp(cityName: 'Dehiwala'),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 35),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Dehiwala',
                                    style: GoogleFonts.adventPro(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      WeatherApp(cityName: 'Kandy'),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 35, left: 20),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Kandy',
                                    style: GoogleFonts.adventPro(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      WeatherApp(cityName: 'Galle'),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 35, left: 20),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Galle',
                                    style: GoogleFonts.adventPro(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (errorMessage == '' && !startLoading)
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        WeatherApp(cityName: 'Sydney'),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 50),
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 35),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sydney',
                                      style: GoogleFonts.adventPro(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        WeatherApp(cityName: 'London'),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 50, left: 35),
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 35),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'London',
                                      style: GoogleFonts.adventPro(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
    );
  }
}
