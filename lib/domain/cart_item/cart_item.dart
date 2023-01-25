import 'package:hive/hive.dart';
part 'cart_item.g.dart';


@HiveType(typeId: 1)
class CartItem extends HiveObject{
  @HiveField(0)
  String title;

  @HiveField(1)
  String  id;

  @HiveField(2)
  String  imageUrl;

  @HiveField(3)
  int  quantity;

  @HiveField(4)
  int price;

  @HiveField(5)
  int  total;

  CartItem({
    required this.id,
    required this.price,
    required this.title,
    required this.imageUrl,
    required this.quantity,
    required this.total
  });

  factory CartItem.formJson(Map<String, dynamic> json){
    return CartItem(
        id: json['id'],
        price: json['price'],
        title: json['title'],
        imageUrl: json['imageUrl'],
        quantity: json['quantity'],
        total: json['total']
    );
  }



  Map<String, dynamic> toJson(){
    return {
      'title': this.title,
      'id': this.id,
      'imageUrl': this.imageUrl,
      'quantity': this.quantity,
      'price': this.price,
      'total': this.total
    };
  }

}
