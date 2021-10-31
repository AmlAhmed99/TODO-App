import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/Archived.dart';
import 'package:todo_app/modules/Done.dart';
import 'package:todo_app/modules/Tasks.dart';
import 'package:todo_app/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  bool isBottomSheet = false;
  IconData fabicon;

  Database database;
  var newTasks = [];
  var doneTasks = [];
  var archiveTasks = [];
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  var screens = [Tasks(), Done(), Archived()];

  List<String> title = ['Tasks Screen', 'Done Screen', 'Archived Screen'];

  void changeIndex(int idx) {
    currentIndex = idx;
    emit(AppChangeBottomNavbarState());
  }

  void createDB() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) async {
      print('database created');
      await database.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT , date TEXT ,time TEXT,status TEXT )');
      print('table created');
      emit(AppCreatDatabaseState());
    }, onOpen: (database) {
      print('database opened');
      getDataFromDatabase(database);
    }).then((value) {
      database = value;
      emit(AppCreatDatabaseState());
    });
  }

  void insertDB({
    @required String title,
    @required String date,
    @required String time,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT Into tasks (title ,date ,time ,status) VALUES  ("$title","$date","$time","new")')
          .then((value) {
        print('inserted successfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print("error in insert data $error");
      });
      return null;
    });
  }

  // database is await but database inside created first.
  getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    emit(AppGetDatabaseState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else if (element['status'] == 'archive') archiveTasks.add(element);
      });
    });
  }

  void updateData({@required String status, @required int id}) async {
    database.rawUpdate('UPDATE tasks SET status = ? where id = ? ',
        ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({@required int id}) async {
    database.rawDelete('DELETE FROM  tasks where id = ? ', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  void ChangeButtomSheet(bool isshow, IconData icon) {
    isBottomSheet = isshow;
    fabicon = icon;
    emit(AppChangeBottomSheetState());
  }
}
