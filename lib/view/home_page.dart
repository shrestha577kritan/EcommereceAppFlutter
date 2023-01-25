import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../application/user/user_notifier.dart';
import '../services/product_service.dart';
import 'cart_page.dart';
import 'create_page.dart';
import 'crud_page.dart';
import 'detail_page.dart';
import 'order_history.dart';



class HomePage extends ConsumerWidget {


  @override
  Widget build(BuildContext context, ref) {
    final authData = ref.watch(userNotifierProvider);
    final productData = ref.watch(productProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
        actions: [
          IconButton(
              onPressed: (){
                Get.to(() => CartPage());
              }, icon: Icon(Icons.shopping_bag))
        ],
      ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(child: Text(authData.user[0].username)),
              ListTile(
                leading: Icon(Icons.email),
                title: Text(authData.user[0].email),
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).pop();
                 Get.to(() => AddPage(), transition: Transition.leftToRight);
                },
                leading: Icon(Icons.add),
                title: Text('create product'),
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).pop();
                  Get.to(() => CrudPage(), transition: Transition.leftToRight);
                },
                leading: Icon(Icons.account_balance_sharp),
                title: Text('Crud Page'),
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).pop();
                  Get.to(() => OrderPage(), transition: Transition.leftToRight);
                },
                leading: Icon(Icons.history),
                title: Text('history'),
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).pop();
                  ref.read(userNotifierProvider.notifier).userLogOut();
                },
                leading: Icon(Icons.exit_to_app),
                title: Text('userLogOut'),
              ),
            ],
          ),
        ),
        body:  Container(
          child: productData.when(
              data: (data){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 4/5
                      ),
                      itemBuilder: (context, index) {
                      final product = data[index];
                         return InkWell(
                           onTap: (){
                             Get.to(() => DetailPage(product), transition:  Transition.leftToRight);
                           },
                           child: GridTile(
                             header: Image.network(product.image, fit: BoxFit.cover, height: 250,),
                             child: Container(),
                             footer: Container(
                               height: 40,
                               color: Colors.black54,
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text(product.product_name, style: TextStyle(color: Colors.white),),
                                     Text('${product.price}', style: TextStyle(color: Colors.white),)
                                   ],
                                 ),
                               ),
                             ),
                           ),
                         );
                      },
                  ),
                );
              },
              error: (err, stack) => Text('$err'),
              loading: () => Center(child: CircularProgressIndicator())
          ),
        )
    );
  }
}
