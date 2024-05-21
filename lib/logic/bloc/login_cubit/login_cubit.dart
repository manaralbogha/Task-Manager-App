import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:task_manager_app/domain/models/Login_model/Login_model.dart';
import 'package:task_manager_app/logic/repositories/login/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;
  LoginCubit({required this.loginRepo}) : super(LoginInitial());

  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login({
    required String userName,
    required String password,
  }) async {
    emit(LoginLoadingState());
    (await loginRepo.login(userName: userName, password: password)).fold(
      (failure) => emit(
        LoginFailureState(failureMsg: failure.errorMsg),
      ),
      (loginModel) => emit(
        LoginSuccessState(loginModel: loginModel),
      ),
    );
  }
}
