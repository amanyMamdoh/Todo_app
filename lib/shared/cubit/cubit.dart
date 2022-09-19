import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql/modules/archivedTasks.dart';
import 'package:sql/modules/doneTasks.dart';
import 'package:sql/modules/newTasks.dart';
import 'package:sql/shared/cubit/states.dart';

class CubitApp extends Cubit <AppState>{
 // CubitApp(AppState initialState) : super(initialState);
  CubitApp():super(intialState());
  //create object
  static CubitApp get(context)=> BlocProvider.of(context);

  List<Map> tasks=[];
  List<Map> new_tasks=[];
  List<Map> done_tasks=[];
  List<Map> archived_tasks=[];
  List<Widget> Screens=[newTasks(),doneTasks(),archivedTasks()];
  List<String> Titles=['New Tasks','Done TASKS','Archived Tasks'];
  var currentIndex=0;
   var database;
  bool isbottomnavigate=false;
  IconData floaticon=Icons.add;

  void changeIndex(int index){
    currentIndex=index;
    emit(changeNavBar());
  }
  void createDatabase() {
     openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database, version) {
          database.execute(
              'create table tasks (id integer primary key, title text, date text, time text,status text)'
          ).then((value) {
            print('table created');
          }).catchError((error) {
            print('error');
          });
        },
        onOpen: (database) {
          GetFromDatabase(database);
          print('database opened');
        }
    ).then((value) {
      database=value;
      print('database created');
      emit(CreateDatabaseState());
     });
  }

  insertIntoDatabase(
      String title,
      String date,
      String time,)  {
    return  database.transaction((txn)async  {
      txn.rawInsert(
          'insert into  tasks (title,date,time,status) values("$title","$date","$time","new")'
      ).then((value) {
       // tasks=value;
        changeBottomSheet(Icons.add, false);
        print('data added');
        emit(InsertIntoDatabaseState());
       GetFromDatabase(database);

      }).catchError((error) {
        print('error during inserting ${error.toString()}');
      });
      return null;
    });
  }
 void GetFromDatabase(database)  {

    emit(GetFromDatabaseStateLoading());
   database.rawQuery("select * from tasks").then((value){
     print(tasks);
     tasks=value;
     tasks.forEach((element) {
       if (element['status']=='done')
         done_tasks.add(element);
       else if(element['status']=='archived')
         archived_tasks.add(element);
       else
         new_tasks.add(element);
     });
     emit(GetFromDatabaseState());
    // emit(UpdateDatabaseState());
   });
  }
  void UpdateDatabase(
      @required String status,
      @required String id
      ) async{
    new_tasks=[];
    done_tasks=[];
    archived_tasks=[];
      database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status',  '$id']).then((value){
          GetFromDatabase(database);
          emit(UpdateDatabaseState());
      });

   // print('updated: $count');
  }
  void DeleteDatabase(
      @required String id
      ) async{
     database.rawDelete('DELETE FROM tasks WHERE id = ?', ['$id']).then((value){
       tasks.removeAt(int.parse(id));
      GetFromDatabase(database);

      emit(DeleteDatabaseState());
     print(value);
    });

    // print('updated: $count');
  }

  void changeBottomSheet(IconData icon,bool show){
    isbottomnavigate=show;
    floaticon=icon;
    emit(ChangeBottomSheetState());
  }
}
