// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app/screens/favoriteCities.dart';
import 'package:weather_app/screens/weatherDetailsPage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> cityList = [
    'Afghanistan',
    'Kabul',
    'Albania',
    'Tirana',
    'Algeria',
    'Algiers',
    'Andorra',
    'Andorra la Vella',
    'Angola',
    'Luanda',
    'Antigua and Barbuda',
    'Saint John\'s',
    'Argentina',
    'Buenos Aires',
    'Armenia',
    'Yerevan',
    'Australia',
    'Canberra',
    'Austria',
    'Vienna',
    'Azerbaijan',
    'Baku',
    'Bahamas',
    'Nassau',
    'Bahrain',
    'Manama',
    'Bangladesh',
    'Dhaka',
    'Barbados',
    'Bridgetown',
    'Belarus',
    'Minsk',
    'Belgium',
    'Brussels',
    'Belize',
    'Belmopan',
    'Benin',
    'Porto-Novo',
    'Bhutan',
    'Thimphu',
    'Bolivia',
    'La Paz',
    'Bosnia and Herzegovina',
    'Sarajevo',
    'Botswana',
    'Gaborone',
    'Brazil',
    'Brasília',
    'Brunei',
    'Bandar Seri Begawan',
    'Bulgaria',
    'Sofia',
    'Burkina Faso',
    'Ouagadougou',
    'Burundi',
    'Bujumbura',
    'Cambodia',
    'Phnom Penh',
    'Cameroon',
    'Yaoundé',
    'Canada',
    'Ottawa',
    'Cape Verde',
    'Praia',
    'Central African Republic',
    'Bangui',
    'Chad',
    'N\'Djamena',
    'Chile',
    'Santiago',
    'China',
    'Beijing',
    'Colombia',
    'Bogotá',
    'Comoros',
    'Moroni',
    'Congo',
    'Brazzaville',
    'Costa Rica',
    'San José',
    'Croatia',
    'Zagreb',
    'Cuba',
    'Havana',
    'Cyprus',
    'Nicosia',
    'Czech Republic',
    'Prague',
    'Denmark',
    'Copenhagen',
    'Djibouti',
    'Djibouti',
    'Dominica',
    'Roseau',
    'Dominican Republic',
    'Santo Domingo',
    'East Timor',
    'Dili',
    'Ecuador',
    'Quito',
    'Egypt',
    'Cairo',
    'El Salvador',
    'San Salvador',
    'Equatorial Guinea',
    'Malabo',
    'Eritrea',
    'Asmara',
    'Estonia',
    'Tallinn',
    'Eswatini',
    'Mbabane',
    'Ethiopia',
    'Addis Ababa',
    'Fiji',
    'Suva',
    'Finland',
    'Helsinki',
    'France',
    'Paris',
    'Gabon',
    'Libreville',
    'Gambia',
    'Banjul',
    'Georgia',
    'Tbilisi',
    'Germany',
    'Berlin',
    'Ghana',
    'Accra',
    'Greece',
    'Athens',
    'Grenada',
    'St. George\'s',
    'Guatemala',
    'Guatemala City',
    'Guinea',
    'Conakry',
    'Guinea-Bissau',
    'Bissau',
    'Guyana',
    'Georgetown',
    'Haiti',
    'Port-au-Prince',
    'Honduras',
    'Tegucigalpa',
    'Hungary',
    'Budapest',
    'Iceland',
    'Reykjavik',
    'India',
    'New Delhi',
    'Indonesia',
    'Jakarta',
    'Iran',
    'Tehran',
    'Iraq',
    'Baghdad',
    'Ireland',
    'Dublin',
    'Israel',
    'Jerusalem',
    'Italy',
    'Rome',
    'Jamaica',
    'Kingston',
    'Japan',
    'Tokyo',
    'Jordan',
    'Amman',
    'Kazakhstan',
    'Nur-Sultan',
    'Kenya',
    'Nairobi',
    'Kiribati',
    'Tarawa',
    'Kosovo',
    'Pristina',
    'Kuwait',
    'Kuwait City',
    'Kyrgyzstan',
    'Bishkek',
    'Laos',
    'Vientiane',
    'Latvia',
    'Riga',
    'Lebanon',
    'Beirut',
    'Lesotho',
    'Maseru',
    'Liberia',
    'Monrovia',
    'Libya',
    'Tripoli',
    'Liechtenstein',
    'Vaduz',
    'Lithuania',
    'Vilnius',
    'Luxembourg',
    'Luxembourg City',
    'Madagascar',
    'Antananarivo',
    'Malawi',
    'Lilongwe',
    'Malaysia',
    'Kuala Lumpur',
    'Maldives',
    'Malé',
    'Mali',
    'Bamako',
    'Malta',
    'Valletta',
    'Marshall Islands',
    'Majuro',
    'Mauritania',
    'Nouakchott',
    'Mauritius',
    'Port Louis',
    'Mexico',
    'Mexico City',
    'Micronesia',
    'Palikir',
    'Moldova',
    'Chisinau',
    'Monaco',
    'Monaco',
    'Mongolia',
    'Ulaanbaatar',
    'Montenegro',
    'Podgorica',
    'Morocco',
    'Rabat',
    'Mozambique',
    'Maputo',
    'Myanmar',
    'Naypyidaw',
    'Namibia',
    'Windhoek',
    'Nauru',
    'Yaren',
    'Nepal',
    'Kathmandu',
    'Netherlands',
    'Amsterdam',
    'New Zealand',
    'Wellington',
    'Nicaragua',
    'Managua',
    'Niger',
    'Niamey',
    'Nigeria',
    'Abuja',
    'North Korea',
    'Pyongyang',
    'North Macedonia',
    'Skopje',
    'Norway',
    'Oslo',
    'Oman',
    'Muscat',
    'Pakistan',
    'Islamabad',
    'Palau',
    'Ngerulmud',
    'Panama',
    'Panama City',
    'Papua New Guinea',
    'Port Moresby',
    'Paraguay',
    'Asunción',
    'Peru',
    'Lima',
    'Philippines',
    'Manila',
    'Poland',
    'Warsaw',
    'Portugal',
    'Lisbon',
    'Qatar',
    'Doha',
    'Romania',
    'Bucharest',
    'Russia',
    'Moscow',
    'Rwanda',
    'Kigali',
    'Saint Kitts and Nevis',
    'Basseterre',
    'Saint Lucia',
    'Castries',
    'Saint Vincent and the Grenadines',
    'Kingstown',
    'Samoa',
    'Apia',
    'San Marino',
    'San Marino',
    'Sao Tome and Principe',
    'São Tomé',
    'Saudi Arabia',
    'Riyadh',
    'Senegal',
    'Dakar',
    'Serbia',
    'Belgrade',
    'Seychelles',
    'Victoria',
    'Sierra Leone',
    'Freetown',
    'Singapore',
    'Singapore',
    'Slovakia',
    'Bratislava',
    'Slovenia',
    'Ljubljana',
    'Solomon Islands',
    'Honiara',
    'Somalia',
    'Mogadishu',
    'South Africa',
    'Pretoria',
    'South Korea',
    'Seoul',
    'South Sudan',
    'Juba',
    'Spain',
    'Madrid',
    'Sri Lanka',
    'Colombo',
    'Sudan',
    'Khartoum',
    'Suriname',
    'Paramaribo',
    'Sweden',
    'Stockholm',
    'Switzerland',
    'Bern',
    'Syria',
    'Damascus',
    'Taiwan',
    'Taipei',
    'Tajikistan',
    'Dushanbe',
    'Tanzania',
    'Dodoma',
    'Thailand',
    'Bangkok',
    'Togo',
    'Lomé',
    'Tonga',
    'Nuku\'alofa',
    'Trinidad and Tobago',
    'Port of Spain',
    'Tunisia',
    'Tunis',
    'Turkey',
    'Ankara',
    'Turkmenistan',
    'Ashgabat',
    'Tuvalu',
    'Funafuti',
    'Uganda',
    'Kampala',
    'Ukraine',
    'Kyiv',
    'United Arab Emirates',
    'Abu Dhabi',
    'United Kingdom',
    'London',
    'United States',
    'Washington, D.C.',
    'Uruguay',
    'Montevideo',
    'Uzbekistan',
    'Tashkent',
    'Vanuatu',
    'Port Vila',
    'Vatican City',
    'Vatican City',
    'Venezuela',
    'Caracas',
    'Vietnam',
    'Hanoi',
    'Yemen',
    'Sanaa',
    'Zambia',
    'Lusaka',
    'Zimbabwe',
    'Harare',
    'Galle',
    'Jaffna',
    'Kandy',
    'Negombo',
    'Anuradhapura',
    'Trincomalee',
    'Nuwara\'Eliya',
    'Batticaloa',
    'Matara',
    'Sydney'
  ];

  List<String> filteredCityList = [];

  void searchCity(String searchQuery) {
    setState(() {
      filteredCityList = cityList
          .where(
              (city) => city.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();

      filteredCityList.sort((a, b) => a.compareTo(b));
    });
  }

  String searchValue = '';
  bool loading = false;
  bool isSearch = false;
  bool isKeyboardVisible = false;

  final textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCityList = cityList;
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void hideKeyboard() {
    setState(() {
      isKeyboardVisible = false;
    });
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
                      SizedBox(height: 35),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 25),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(25)),
                                border: Border.all(
                                    width: 1, color: Colors.blueGrey),
                              ),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    searchValue = value;
                                  });
                                  searchCity(value);
                                },
                                onTap: () => {
                                  setState(() {
                                    isKeyboardVisible = true;
                                  })
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter text',
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 26,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(25)),
                                color: Colors.blueGrey),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blueGrey),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                textStyle: MaterialStateProperty.all<TextStyle>(
                                  GoogleFonts.cutive(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(25))),
                                ),
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(
                                  EdgeInsets.symmetric(
                                      vertical: 18, horizontal: 16),
                                ),
                              ),
                              onPressed: () {
                                searchValue != ''
                                    ? setState(() async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => WeatherApp(
                                                cityName: searchValue),
                                          ),
                                        );
                                        loading = false;
                                        hideKeyboard();
                                        isSearch = false;
                                        await Future.delayed(
                                            Duration(seconds: 1));
                                        searchValue = '';
                                      })
                                    : setState(() {
                                        loading = false;
                                        hideKeyboard();
                                        isSearch = false;
                                      });
                                Navigator.pop(context);
                              },
                              child: Text(
                                searchValue != '' ? 'Search' : 'Cancel',
                                style: GoogleFonts.cutive(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: ListView.builder(
                            itemCount: filteredCityList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WeatherApp(
                                            cityName: filteredCityList[index]
                                                .toString()),
                                      ),
                                    )
                                  },
                                  child: Text(
                                    filteredCityList[index],
                                    style: GoogleFonts.cutive(
                                        fontSize: 13,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: !isKeyboardVisible,
                    child: Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
