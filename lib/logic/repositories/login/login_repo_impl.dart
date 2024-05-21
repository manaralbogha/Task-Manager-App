import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task_manager_app/domain/models/Login_model/Login_model.dart';
import 'package:task_manager_app/domain/remote/dio_helper.dart';
import 'package:task_manager_app/domain/remote/end_points.dart';
import 'package:task_manager_app/logic/core/error/failures.dart';
import 'package:task_manager_app/logic/repositories/login/login_repo.dart';

class LoginRepoImpl extends LoginRepo {
  @override
  Future<Either<Failure, LoginModel>> login({
    required String userName,
    required String password,
  }) async {
    try {
      var response =
          await DioHelper.postData(url: EndPoints.loginEndPoint, body: {
        "username": userName,
        "password": password,
      });

      return right(LoginModel.fromJson(response.data));
    } catch (ex) {
      log('There is an error in login method in LoginRepoImpl');

      if (ex is DioException) {
        if (ex.response?.statusCode == 401 || ex.response?.statusCode == 400) {
          return left(
            Failure(
              errorMsg: ex.response?.data['message'] ??
                  'Something Went Wrong, Please Try Again',
            ),
          );
        }
      }

      return left(Failure(errorMsg: 'Something Went Wrong, Please Try Again'));
    }
  }
}
