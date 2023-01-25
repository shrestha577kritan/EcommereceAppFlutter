import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterrun/view/sign_up_page.dart';
import 'package:get/get.dart';

import '../application/user/user_notifier.dart';
import '../commons/snack_show.dart';





class LoginPage extends ConsumerWidget {

  final mailController = TextEditingController();
  final passController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(userNotifierProvider, (previous, next) {
      if(next.errorMessage.isNotEmpty){
        SnackShow.ShowSnackBar(context: context,message:  next.errorMessage);
      }
    });
    // final mode = ref.watch(validateProvider);
    final auth = ref.watch(userNotifierProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
             // autovalidateMode: mode,
            key: _form,
            child: Container(
              padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 45, top: 10),
                    child: Text('Login Form', style: TextStyle(fontSize: 22, color: Colors.black, letterSpacing: 2, fontFamily: 'Nunito'),),
                  ),

                  SizedBox(height: 20.h,),
                  TextFormField(
                    controller: mailController,
                    validator: (val){
                      // final bool emailValid =
                      // RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      //     .hasMatch(val!);
                      // print(emailValid);
                      if(val!.isEmpty){
                        return 'please provide email';
                      }else if(!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(val.trim())){
                        return 'please provide valid email';
                      }
                      return null;
                    },
                    decoration:  InputDecoration(
                        hintText: 'Email',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  TextFormField(
                    controller: passController,
                    // inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    validator: (val){
                      if(val!.isEmpty){
                        return 'please provide password';
                      }else if(val.length > 20){
                        return 'password character is limit to less than 20';
                      }
                      return null;
                    },
                      obscureText: true,
                    decoration:  InputDecoration(
                        hintText: 'Password',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  ElevatedButton(
                      onPressed: auth.isLoad ? null : (){
                        // final m = passController.text.trim().replaceAll(RegExp('\\s+'), ' ');
                        FocusScope.of(context).unfocus();
                        _form.currentState!.save();
                        if(_form.currentState!.validate()){
                            ref.read(userNotifierProvider.notifier).userLogin(
                                email: mailController.text.trim(),
                                password: passController.text.trim()
                            );
                        }else{
                          // ref.read(validateProvider.notifier).toggleState();
                        }


                      }, child: auth.isLoad ? Center(child: CircularProgressIndicator()) :
                   Text('Login' )),
                  SizedBox(height: 20.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account'),
                      TextButton(onPressed: (){
                        // _form.currentState!.reset();
                        Get.to(() => SignUpPage(), transition: Transition.leftToRight);
                      }, child: Text('Sign Up'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
