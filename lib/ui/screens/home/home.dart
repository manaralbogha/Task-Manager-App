import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/domain/models/todo_model/todo_model.dart';
import 'package:task_manager_app/logic/bloc/home_cubit/home_cubit.dart';
import 'package:task_manager_app/logic/core/app_router.dart';
import 'package:task_manager_app/ui/helpers/app_colors.dart';
import 'package:task_manager_app/ui/helpers/cache_helper.dart';
import 'package:task_manager_app/ui/helpers/space_widgets.dart';
import 'package:task_manager_app/ui/screens/home/Widget/bottom_sheet_Widget.dart';
import 'package:task_manager_app/ui/screens/home/Widget/todo_card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            title: const Text(
              "Manager App",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.defaultColor),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    await CacheHelper.deleteData(key: "userId");
                    await CacheHelper.setStringList(key: "todo", list: []);
                    context.go(AppRouter.kLogInPage);
                  },
                  child: Text("Logout"),
                ),
              )
            ],
            centerTitle: true,
          ),
          body: const HomeBody(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return const BottomSheetWidget();
                },
              );
            },
            backgroundColor: AppColors.defaultColor,
            child: const Icon(
              Icons.add,
              color: AppColors.backgroundColor,
            ),
          ),
        );
      },
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
        if (state is GetAllTodoByUserIdLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetAllTodoByUserIdSuccessState) {
          homeCubit.todo = [];
          List<String> todoLocal = CacheHelper.getStringList(key: "todo") ?? [];

          homeCubit.todo = state.todosModel.todo;
          for (var item in todoLocal) {
            var todo = json.decode(item);
            homeCubit.todo.add(Todo.fromJson(todo));
          }
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemBuilder: (context, index) => TodoCardWidget(
              todo: homeCubit.todo[index],
              homeCubit: homeCubit,
            ),
            separatorBuilder: (context, index) => const VerticalSpace(.5),
            itemCount: homeCubit.todo.length,
          ),
        );
      },
    );
  }
}
