import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql/shared/components.dart';
import 'package:sql/shared/cubit/cubit.dart';
import 'package:sql/shared/cubit/states.dart';

class archivedTasks extends StatelessWidget {
  const archivedTasks({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<CubitApp,AppState>(
      listener:(context,state) {},
      builder:(context,state){
        var tasks=CubitApp.get(context).archived_tasks;
        return  TaskBuildeCondition(tasks: tasks);
      } ,
    );



  }
}