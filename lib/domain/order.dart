
import 'cart_item/cart_item.dart';

class Order{

  final int amount;
  final String userId;
  final List<CartItem> products;
  final String dateTime;

  Order({
    required this.amount,
    required this.dateTime,
    required this.products,
    required this.userId
  });

  factory Order.formJson(Map<String, dynamic> json){
    return Order(
        amount: json['amount'],
        dateTime: json['dateTime'],
        products: (json['products'] as List).map((e) => CartItem.formJson(e)).toList(),
        userId: json['userId']
    );
  }

}