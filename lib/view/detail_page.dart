import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterrun/commons/snack_show.dart';
import 'package:flutterrun/domain/product/product.dart';
import 'package:flutterrun/providers/cart_provider.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'cart_page.dart';



class DetailPage extends StatelessWidget {
final Product product;
DetailPage(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(product.image, height: 275.h,),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.product_detail),
                        ],
                      ),
                    ),
                  ],
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(360.w, 45)
                              ),
                              onPressed: () {
                                final response = ref.read(cartProvider.notifier).addToCart(product);
                                SnackShow.ShowSnackBar(context: context, message: response, s: SnackBarAction(
                                    label: 'Go To Cart',
                                    textColor: Colors.white,
                                    onPressed: (){
                                      Get.to(() => CartPage(),  transition: Transition.leftToRight);
                                }));
                              },
                              child: Text('Add To Cart')
                          ),
                        )
                    );
                  }
                )
              ],
            ),
          ),
        )
    );
  }
}
