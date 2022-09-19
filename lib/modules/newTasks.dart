import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql/shared/components.dart';
import 'package:sql/shared/cubit/cubit.dart';
import 'package:sql/shared/cubit/states.dart';

class newTasks extends StatelessWidget {
  const newTasks({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<CubitApp,AppState>(
      listener:(context,state) {},
      builder:(context,state){
       var tasks=CubitApp.get(context).new_tasks;
       return TaskBuildeCondition(tasks: tasks);
      } ,
    );



  }
}