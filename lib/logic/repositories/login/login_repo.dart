import 'package:dartz/dartz.dart';
import 'package:task_manager_app/domain/models/Login_model/Login_model.dart';
import 'package:task_manager_app/logic/core/error/failures.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginModel>> login({
    required String userName,
    required String password,
  });
}
