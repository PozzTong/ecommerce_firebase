class ShoeModel {
  final String id;
  final String name;
  final String image;
  final double price;
  int qty;
  final String cate;

  ShoeModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.qty,
    required this.cate,
  });

  factory ShoeModel.fromJson(Map<String, dynamic> json) {
    return ShoeModel(
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
    };
  }

  void decreaseStock(int quantity) {
    if (qty >= quantity) {
      qty -= quantity;
    }
  }

  void increaseStock(int quantity) {
    qty += quantity;
  }
}
