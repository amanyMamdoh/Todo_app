
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql/modules/archivedTasks.dart';
import 'package:sql/modules/doneTasks.dart';
import 'package:sql/shared/blocObserver.dart';
import 'package:sql/shared/cubit/cubit.dart';
import 'package:sql/shared/cubit/states.dart';
import 'layout/homeLayout.dart';
import 'modules/newTasks.dart';
import 'shared/constantes.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';



void main(){
  BlocOverrides.runZoned(
        () {

          runApp(
              MaterialApp(
                  home: myapp()


              )
          );
    },
    blocObserver: MyBlocObserver(),
  );

}




