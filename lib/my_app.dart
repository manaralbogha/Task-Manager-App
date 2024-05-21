import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/logic/bloc/home_cubit/home_cubit.dart';
import 'package:task_manager_app/logic/core/app_router.dart';
import 'package:task_manager_app/logic/repositories/home/home_repo_impl.dart';
import 'package:task_manager_app/ui/helpers/app_colors.dart';
import 'package:task_manager_app/ui/helpers/size_config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return BlocProvider(
      create: (context) =>
          HomeCubit(homeRepo: HomeRepoImpl())..getAllTodoByUserId(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: AppColors.defaultColor,
          scaffoldBackgroundColor: AppColors.backgroundColor,
          useMaterial3: true,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
