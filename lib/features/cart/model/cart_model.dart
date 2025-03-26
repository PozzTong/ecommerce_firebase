import '../../feature.dart';

class CartModel {
  final ShoeModel shoe;
  int quantity;

  CartModel({
    required this.shoe,
    required this.quantity,
  });
  Map<String, dynamic> toJson() {
    return {'shoe': shoe.toJson(), 'quantity': quantity};
  }

  // Convert ShoeModel to CartModel
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      shoe: ShoeModel.fromJson(json['shoe']),
      quantity: json['quantity'],
    );
  }
}
