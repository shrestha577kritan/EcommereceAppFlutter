import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterrun/domain/cart_item/cart_item.dart';
import 'package:flutterrun/domain/product/product.dart';
import 'package:hive/hive.dart';
import 'box_provider.dart';



final cartProvider = StateNotifierProvider<CartProvider, List<CartItem>>((ref) => CartProvider(
  ref.watch(cartBox).values.toList(), ref.watch(cartBox)
)
);

class CartProvider extends StateNotifier<List<CartItem>>{
  final Box<CartItem> box;
  CartProvider(super.state, this.box);

  String addToCart(Product product){
     if(state.isEmpty){
        final newCartItem  = CartItem(
            id: product.id,
            price: product.price,
            title: product.product_name,
            imageUrl: product.image,
            quantity: 1,
            total: product.price
        );
        box.add(newCartItem);
        state = [newCartItem];
        return 'successfully added to cart';
     }else{
       final isThere = state.firstWhere((element) => element.id == product.id,
           orElse: () => CartItem(id: '', price: 0, title: 'no', imageUrl: '', quantity: 0, total: 0)
       );
       if(isThere.title == 'no'){
         final newCartItem  = CartItem(
             id: product.id,
             price: product.price,
             title: product.product_name,
             imageUrl: product.image,
             quantity: 1,
             total: product.price
         );
         box.add(newCartItem);
         state = [...state, newCartItem];
         return 'successfully added to cart';
       }else{
         return 'already added to cart';
       }

     }
  }

  void removeFromCart(CartItem cartItem){
    cartItem.delete();
    state.remove(cartItem);
    state = [...state];
  }

  void singleAddCart(CartItem cartItem){
     cartItem.quantity = cartItem.quantity + 1;
     cartItem.save();
     state = [
       for(final cart in state)
         if(cart == cartItem) cartItem else cart
     ];
  }


  void singleRemoveCart(CartItem cartItem){
     if(cartItem.quantity > 1){
       cartItem.quantity = cartItem.quantity - 1;
       cartItem.save();
       state = [
         for(final cart in state)
           if(cart == cartItem) cartItem else cart
       ];
     }
  }

  double get total {
    double total = 0;
    for(final cart in state){
       total += cart.quantity * cart.price;
    }
    print(total);
    return total;
  }

  void clearCart(){
   box.clear();
   state = [];
  }

}