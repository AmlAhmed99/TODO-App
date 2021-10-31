import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/components/dafaultFormField.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class homeScreen extends StatelessWidget {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  var TaskTitleEditingController = TextEditingController();
  var TaskTimeEditingController = TextEditingController();
  var TaskDateEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDB(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              title: Text(cubit.title[cubit.currentIndex]),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(cubit.fabicon),
              onPressed: () {
                if (cubit.isBottomSheet) {
                  if (formkey.currentState.validate()) {
                    cubit.insertDB(
                        title: TaskTitleEditingController.text,
                        date: TaskDateEditingController.text,
                        time: TaskTimeEditingController.text);
                  }
                } else {
                  scaffoldkey.currentState
                      .showBottomSheet(
                        (context) => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Form(
                            key: formkey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                  controller: TaskTitleEditingController,
                                  label: 'TaskTitle',
                                  prefix: Icon(Icons.title),
                                  validator: (String val) {
                                    if (val.isEmpty) {
                                      return 'title must not be empty';
                                    }
                                    return null;
                                  },
                                  type: TextInputType.text,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                defaultFormField(
                                  controller: TaskTimeEditingController,
                                  label: 'TaskTime',
                                  prefix: Icon(Icons.watch_later),
                                  validator: (String val) {
                                    if (val.isEmpty) {
                                      return 'time must not be empty';
                                    }
                                    return null;
                                  },
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      TaskTimeEditingController.text =
                                          value.format(context).toString();
                                      print(value.format(context).toString());
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                defaultFormField(
                                  controller: TaskDateEditingController,
                                  label: 'TaskDate',
                                  prefix: Icon(Icons.calendar_today),
                                  validator: (String val) {
                                    if (val.isEmpty) {
                                      return 'date must not be empty';
                                    }
                                    return null;
                                  },
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate:
                                                DateTime.parse('2021-11-03'))
                                        .then((value) {
                                      TaskDateEditingController.text =
                                          DateFormat.yMMMd().format(value);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 10,
                      )
                      .closed
                      .then((value) {
                    cubit.ChangeButtomSheet(false, Icons.edit);
                  });
                  cubit.ChangeButtomSheet(true, Icons.add);
                }
              },
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (idx) {
                cubit.changeIndex(idx);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu), label: 'Archived'),
              ],
            ),
          );
        },
      ),
    );
  }
}
