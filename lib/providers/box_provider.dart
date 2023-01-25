import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterrun/domain/cart_item/cart_item.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../domain/user/user.dart';




final userBox = Provider((ref) {
  return Hive.box<User>('user');
});


final cartBox = Provider((ref) {
  return Hive.box<CartItem>('carts');
});