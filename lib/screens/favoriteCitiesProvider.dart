import 'package:flutter/foundation.dart';
import 'city.dart';

class FavoriteCitiesProvider extends ChangeNotifier {
  List<City> _favoriteCities = [];

  List<City> get favoriteCities => _favoriteCities;

  void toggleFavorite(City city) {
    print(_favoriteCities);
    city.isFavorite = !city.isFavorite;
    notifyListeners();
  }

  void addFavoriteCity(City city) {
    print(_favoriteCities);
    _favoriteCities.add(city);
    notifyListeners();
  }

  void removeFavoriteCity(City city) {
    _favoriteCities.remove(city);
    notifyListeners();
  }
}
