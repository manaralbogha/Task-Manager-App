import 'package:flutter/material.dart';
import 'package:task_manager_app/domain/remote/dio_helper.dart';
import 'package:task_manager_app/my_app.dart';
import 'package:task_manager_app/ui/helpers/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  runApp(const MyApp());
}
