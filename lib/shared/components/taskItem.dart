import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class TaskItem extends StatelessWidget {
  Map model;

  TaskItem(this.model);

  @override
  Widget build(BuildContext context) {
    return  Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        width: double.infinity,
        height: 60,
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                '${model['title']}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              radius: 40,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['time']}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
              icon: Icon(
                Icons.check_box,
                color: Colors.green,
              ),
              onPressed: () {
                AppCubit.get(context).updateData(status: 'done', id: model['id']);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.archive,
                color: Colors.black54,
              ),
              onPressed: () {
                AppCubit.get(context).updateData(status: 'archive', id: model['id']);
              },
            )
          ],
        ),
      ),
    );

  }
}
