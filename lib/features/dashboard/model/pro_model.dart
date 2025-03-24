class ProModel {
  final String id;
  final String name;
  final String image;
  final dynamic price;
  final dynamic qty;

  ProModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.qty,
  });

  factory ProModel.fromMap(String id, Map<String, dynamic> data) {
    return ProModel(
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
