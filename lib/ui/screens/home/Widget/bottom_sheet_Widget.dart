import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/logic/bloc/home_cubit/home_cubit.dart';
import 'package:task_manager_app/ui/helpers/app_colors.dart';
import 'package:task_manager_app/ui/helpers/cache_helper.dart';
import 'package:task_manager_app/ui/helpers/custom_snack_bar.dart';
import 'package:task_manager_app/ui/helpers/custom_text_field.dart';
import 'package:task_manager_app/ui/helpers/size_config.dart';
import 'package:task_manager_app/ui/helpers/space_widgets.dart';
import 'package:task_manager_app/ui/widgets/custom_button.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) => {
        if (state is AddTodoSuccessState)
          {
            Navigator.pop(context),
            CustomSnackBar.showCustomSnackBar(
              context,
              message: "Todo added successfully",
              backgroundColor: Colors.green,
            ),
          }
      },
      builder: (context, state) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Form(
            key: homeCubit.formKey,
            child: Container(
              height: SizeConfig.defaultSize * 38,
              decoration: const BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomTextField(
                      controller: homeCubit.todoController,
                      width: SizeConfig.defaultSize * 38,
                      hintText: " Add Todo",
                      prefixIcon: Icons.task,
                      keyboardType: TextInputType.text,
                      maxLines: 5,
                    ),
                    const VerticalSpace(2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Completed",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.defaultSize * 2,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Checkbox(
                          value: homeCubit.checkCompleted,
                          onChanged: (value) {
                            homeCubit.changeCheckCompleted();
                          },
                          activeColor: AppColors.defaultColor,
                        ),
                      ],
                    ),
                    const VerticalSpace(2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          text: "Close",
                          width: SizeConfig.defaultSize * 13,
                          color: Colors.red,
                          onTap: () {
                            Navigator.pop(context);
                            homeCubit.todoController.clear();
                          },
                        ),
                        const HorizontalSpace(2),
                        CustomButton(
                          text: "Add",
                          width: SizeConfig.defaultSize * 13,
                          color: Colors.green,
                          onTap: () async {
                            if (homeCubit.formKey.currentState!.validate()) {
                              var userId =
                                  await CacheHelper.getData(key: "userId");
                              await homeCubit.addTodo(
                                todo: homeCubit.todoController.text,
                                completed: homeCubit.checkCompleted,
                                userId: userId,
                              );
                              homeCubit.todoController.clear();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
