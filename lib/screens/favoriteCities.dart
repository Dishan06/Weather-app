import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/homePage.dart';
import 'package:weather_app/screens/weatherDetailsPage.dart';
import 'city.dart';
import 'favoriteCitiesProvider.dart';

class FavoriteCitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteCitiesProvider = Provider.of<FavoriteCitiesProvider>(context);
    final favoriteCities = favoriteCitiesProvider.favoriteCities;
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
            child: Column(
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
                          color: isDarkMode ? Colors.white : Colors.blueGrey,
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
                                color:
                                    isDarkMode ? Colors.white : Colors.blueGrey,
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
                Expanded(
                  child: ListView.builder(
                    itemCount: favoriteCities.length,
                    itemBuilder: (context, index) {
                      final city = favoriteCities[index];
                      return ListTile(
                        title: Text(
                          city.name,
                          style: GoogleFonts.adventPro(
                            fontSize: 22,
                            color: isDarkMode ? Colors.white : Colors.blueGrey,
                          ),
                        ),
                        trailing: IconButton(
                          // ignore: prefer_const_constructors
                          icon: Icon(
                            Icons.star,
                            size: 30,
                          ),
                          color: isDarkMode
                              ? city.isFavorite
                                  ? Colors.amber
                                  : Colors.white
                              : city.isFavorite
                                  ? Colors.amber
                                  : Colors.blueGrey,
                          onPressed: () {
                            if (city.isFavorite) {
                              favoriteCitiesProvider.removeFavoriteCity(
                                  City(name: city.name, isFavorite: false));
                            }
                          },
                        ),
                        onTap: () {},
                      );
                    },
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
