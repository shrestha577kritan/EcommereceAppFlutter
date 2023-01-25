import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterrun/application/user/user_state.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/user/i_user.dart';
import '../../domain/user/user.dart';
import '../../providers/box_provider.dart';
import '../../services/user_service.dart';



final userNotifierProvider = StateNotifierProvider<UserNotifier, UserState>((ref) => UserNotifier(
    UserState(isLoad: false, errorMessage: '', isSuccess: false, user: ref.watch(userBox).values.toList()),
    ref.watch(userServiceProvider)
));

class UserNotifier extends StateNotifier<UserState>{
  final UserInterface userInterface;
  UserNotifier(super.state, this.userInterface);

  Future<void> userLogin({required String email, required String password}) async {
    state = state.copyWith(errorMessage: '', isLoad: true);
      final response = await userInterface.userLogin(email: email, password: password);
      response.fold((l) =>state = state.copyWith(errorMessage: l, isLoad: false, user: []),
              (r) => state = state.copyWith(errorMessage: '', isLoad: false, user: [r]));
  }


  Future<void> userSignUp({required String username, required String email, required String password}) async {
    state = state.copyWith(errorMessage: '', isLoad: true);
    final response = await userInterface.userSignUp(email: email, password: password, username: username);
    response.fold((l) =>state = state.copyWith(errorMessage: l, isLoad: false, user: []),
            (r) => state = state.copyWith(errorMessage: '', isLoad: false, user: [], isSuccess: true));
  }


  void userLogOut(){
    Hive.box<User>('user').clear();
    state = state.copyWith(user: []);
  }

}