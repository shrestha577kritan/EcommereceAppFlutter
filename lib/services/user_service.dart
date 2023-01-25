import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterrun/api.dart';
import 'package:flutterrun/domain/user/user.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../domain/user/i_user.dart';
import '../providers/box_provider.dart';
import '../providers/dio_provider.dart';



final userServiceProvider = Provider((ref) => UserService(ref.watch(dioProvider), ref.watch(userBox)));

class UserService implements UserInterface{
  final Box<User> box;
  final Dio dio;
  UserService(this.dio, this.box);

  @override
  Future<Either<String, User>> userLogin({required String email, required String password}) async {
     try{
       final response = await dio.post(Api.userLogin, data: {
           "email": email,
           "password": password
       });
       final user = User.fromJson(response.data);
       box.add(user);
       return Right(user);
     } on DioError catch(err){
      return Left(err.message);
     }
  }

  @override
  Future<Either<String, User>> userSignUp({required String username, required String email, required String password}) async {
    try{
      final response = await dio.post(Api.userSignUp, data: {
        "full_name": username,
        "email": email,
        "password": password
      });
      final user = User.fromJson(response.data);
      return Right(user);
    } on DioError catch(err){
      return Left('');
    }
  }

}