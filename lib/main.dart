import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterrun/domain/cart_item/cart_item.dart';
import 'package:flutterrun/location/location_check.dart';
import 'package:flutterrun/view/status_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';

import 'domain/user/user.dart';


void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(milliseconds: 500));
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CartItemAdapter());
  await Hive.openBox<User>('user');
  await Hive.openBox<CartItem>('carts');
  runApp(ProviderScope(child: Home(),));
}


class Home extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 866),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return GetMaterialApp(
          theme: ThemeData(
            fontFamily: 'Nunito'
          ),
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child:LocationCheck()
      // StatusPage(),
    );
  }
}
