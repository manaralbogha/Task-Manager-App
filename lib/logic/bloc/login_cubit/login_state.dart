part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginFailureState extends LoginState {
  final String failureMsg;

  LoginFailureState({required this.failureMsg});
}

final class LoginSuccessState extends LoginState {
  final LoginModel loginModel;

  LoginSuccessState({required this.loginModel});
}
