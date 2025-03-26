import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoeModels {
  final String id;
  final String name;
  final String image;
  final double price;
  int qty;
  final String cate;
  var isFavorite = false.obs;

  ShoeModels({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.qty,
    required this.cate,
    bool? isFavorite,
  }) {
    this.isFavorite.value = isFavorite ?? false;
    _loadFavoriteStatus();
  }

  factory ShoeModels.fromJson(Map<String, dynamic> json) {
    return ShoeModels(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      image: json['image'] ?? '',
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : (json['price'] is double)
              ? json['price'] as double
              : double.tryParse(json['price'].toString()) ?? 0.0,
      qty: (json['qty'] is int)
          ? json['qty']
          : int.tryParse(json['qty'].toString()) ?? 0,
      cate: json['cate'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'qty': qty,
      'cate': cate,
      'isFavorite': isFavorite.value,
    };
  }

  // Toggle favorite status and save to SharedPreferences
  void toggleFavorite() async {
    isFavorite.value = !isFavorite.value;
    await _saveFavoriteStatus();
  }

  // Decrease the stock of the shoe
  void decreaseStock(int quantity) {
    if (qty >= quantity) {
      qty -= quantity;
    }
  }

  // Increase the stock of the shoe
  void increaseStock(int quantity) {
    qty += quantity;
  }


  Future<void> _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFavorite.value = prefs.getBool(id) ?? false;
  }

  // Save favorite status to SharedPreferences
  Future<void> _saveFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(id, isFavorite.value);
  }
}
