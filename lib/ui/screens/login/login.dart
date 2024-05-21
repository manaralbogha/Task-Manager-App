import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/logic/bloc/login_cubit/login_cubit.dart';
import 'package:task_manager_app/logic/core/app_router.dart';
import 'package:task_manager_app/logic/repositories/login/login_repo_impl.dart';
import 'package:task_manager_app/ui/helpers/app_colors.dart';
import 'package:task_manager_app/ui/helpers/cache_helper.dart';
import 'package:task_manager_app/ui/helpers/custom_snack_bar.dart';
import 'package:task_manager_app/ui/helpers/custom_text_field.dart';
import 'package:task_manager_app/ui/helpers/size_config.dart';
import 'package:task_manager_app/ui/helpers/space_widgets.dart';
import 'package:task_manager_app/ui/widgets/custom_button.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => LoginCubit(loginRepo: LoginRepoImpl()),
        child: const Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: LogInBody(),
        ),
      ),
    );
  }
}

class LogInBody extends StatelessWidget {
  const LogInBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          CustomSnackBar.showCustomSnackBar(
            context,
            message: "You have been logged in successfully",
          );
          CacheHelper.saveData(key: "userId", value: state.loginModel.id);
          context.pushReplacement(AppRouter.kHomePage);
        }
        if (state is LoginFailureState) {
          CustomSnackBar.showCustomSnackBar(
            context,
            message: state.failureMsg,
            backgroundColor: Colors.red,
          );
        }
      },
      builder: (context, state) {
        final LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Form(
              key: loginCubit.formKey,
              child: Column(
                children: [
                  const VerticalSpace(8),
                  FlutterLogo(
                    size: SizeConfig.defaultSize * 15,
                  ),
                  Text(
                    "LogIn",
                    style: TextStyle(
                      fontSize: SizeConfig.defaultSize * 8,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                      color: AppColors.defaultColor,
                    ),
                  ),
                  const VerticalSpace(8),
                  CustomTextField(
                    controller: loginCubit.userNameController,
                    hintText: " User Name",
                    keyboardType: TextInputType.text,
                    suffixIcon: const Icon(Icons.person_2_outlined),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Please enter your username";
                      }
                      return null;
                    },
                  ),
                  const VerticalSpace(2),
                  CustomTextField(
                    controller: loginCubit.passwordController,
                    hintText: " password",
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: const Icon(Icons.password_rounded),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                  ),
                  const VerticalSpace(5),
                  CustomButton(
                    text: "LOGIN",
                    height: SizeConfig.defaultSize * 6,
                    borderRadius: 10,
                    onTap: () {
                      log(loginCubit.formKey.currentState.toString());
                      if (loginCubit.formKey.currentState!.validate()) {
                        log(loginCubit.userNameController.text);
                        log(loginCubit.passwordController.text);
                        loginCubit.login(
                          userName: loginCubit.userNameController.text,
                          password: loginCubit.passwordController.text,
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
