import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/noTasksWidget.dart';
import 'package:todo_app/shared/components/taskItem.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
        return ConditionalBuilder(
          condition: tasks.isNotEmpty,
          fallback: (context) {
            return NoTasks();
          },
          builder: (context) {
            return ListView.separated(
                itemBuilder: (ctx, idx) {
                  return TaskItem(tasks[idx]);
                },
                separatorBuilder: (ctx, idx) {
                  return Divider(
                    color: Colors.blue,
                  );
                },
                itemCount: tasks.length);
          },
        );
      },
    );
  }
}
