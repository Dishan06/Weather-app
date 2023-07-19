class City {
  final String name;
  bool isFavorite;

  City({required this.name, this.isFavorite = false});

  @override
  bool operator ==(other) {
    return other is City && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return '(name: $name, isFavorite: $isFavorite)';
  }
}
