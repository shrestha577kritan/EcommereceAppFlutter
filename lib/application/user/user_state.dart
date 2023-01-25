import '../../domain/user/user.dart';


class UserState {

  final List<User> user;
  final bool isLoad;
  final String errorMessage;
  final bool isSuccess;

  UserState({
    required this.isLoad,
    required this.errorMessage,
    required this.user,
    required this.isSuccess
});

   UserState copyWith({
     List<User>? user,
     bool? isLoad,
     String? errorMessage,
     bool? isSuccess
  }){
    return UserState(
        isLoad: isLoad ?? this.isLoad,
        errorMessage: errorMessage ?? this.errorMessage,
        user: user ?? this.user,
      isSuccess:  isSuccess ?? this.isSuccess
    );
  }

}