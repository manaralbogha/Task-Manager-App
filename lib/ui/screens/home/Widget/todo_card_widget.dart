import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/domain/models/todo_model/todo_model.dart';
import 'package:task_manager_app/logic/bloc/home_cubit/home_cubit.dart';
import 'package:task_manager_app/ui/helpers/custom_snack_bar.dart';
import 'package:task_manager_app/ui/helpers/size_config.dart';
import 'package:task_manager_app/ui/helpers/space_widgets.dart';
import 'package:task_manager_app/ui/screens/home/Widget/icon_button_widget.dart';

class TodoCardWidget extends StatelessWidget {
  const TodoCardWidget({
    super.key,
    required this.todo,
    required this.homeCubit,
  });

  final Todo todo;
  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is DeleteTodoSuccessState) {
          CustomSnackBar.showCustomSnackBar(
            context,
            message: "Todo deleted successfully",
            backgroundColor: Colors.green,
          );
        }
      },
      builder: (context, state) {
        return Card(
          color: todo.completed ? Colors.white12 : Colors.blue.withOpacity(.2),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.todo,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.defaultSize * 2,
                    letterSpacing: 2,
                    wordSpacing: 3,
                  ),
                ),
                const VerticalSpace(2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    todo.completed
                        ? Text(
                            "done 👍🏽",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.defaultSize * 2.5,
                              color: Colors.green,
                            ),
                          )
                        : IconButtonWidget(
                            onTap: () {
                              log("OK");
                            },
                            icon: Icons.done_outline_rounded,
                            color: Colors.green.shade600,
                            splashColor: Colors.green.shade200,
                          ),
                    IconButtonWidget(
                      onTap: () {
                        homeCubit.deleteTodo(
                          todoId: todo.userId,
                        );
                      },
                      icon: Icons.delete_outline_rounded,
                      color: Colors.red,
                      splashColor: Colors.red.shade200,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
