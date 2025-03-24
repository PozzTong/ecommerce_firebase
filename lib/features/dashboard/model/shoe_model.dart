class ShoeModel {
  final String id;
  final String name;
  final String image;
  final dynamic price;
  final dynamic qty;

  ShoeModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.qty,
  });

  factory ShoeModel.fromMap(String id, Map<String, dynamic> data) {
    return ShoeModel(
      id: id,
      name: data['name'] ?? 'Unknown',
      image: data['image'] ?? '',
      price: (data['price'] is int)
          ? (data['price'] as int).toDouble()
          : (data['price'] is double)
              ? data['price'] as double
              : double.tryParse(data['price'].toString()) ?? 0.0,
      qty: (data['qty'] is int)
          ? data['qty']
          : int.tryParse(data['qty'].toString()) ?? 0,
    );
  }
}
