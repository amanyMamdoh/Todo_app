import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:sql/shared/cubit/cubit.dart';

Widget buildTaskItem(Map items,context)=>Dismissible(
   key: UniqueKey(),
  child:   Padding(
    padding: EdgeInsets.all(20),
    child: Row(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: Colors.red,
          child: Center(child:Text('${items['date']}')),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${items['title']}',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              Text('${items['time']}',
                 style: TextStyle(color:Colors.grey)
                ,)
            ],
          ),
        ),
        IconButton(
            onPressed: (){
              CubitApp.get(context).UpdateDatabase('done', '${items['id']}');
            },
            icon: Icon(Icons.check_box_rounded,
            color: Colors.red,)),
        IconButton(
            onPressed: (){
              CubitApp.get(context).UpdateDatabase('archived', '${items['id']}');
               },
            icon: Icon(Icons.archive_outlined,
            color: Colors.grey,)),
      ],
    ),
  ),
  onDismissed: (direction){
    CubitApp.get(context).DeleteDatabase('${items['id']}');


  },
);
Widget TaskBuildeCondition({
     required List<Map> tasks})=>
   ConditionalBuilder(
    condition: tasks.length>0,
    builder: (context)=>
        ListView.separated(
            itemBuilder: (context,index)=>buildTaskItem(tasks[index],context),
        separatorBuilder: (context,index)=>Container(
          width: double.infinity,
          height: 1,
          color: Colors.yellow.withOpacity(0.5),
          margin: EdgeInsets.only(left: 20,right: 20),
        ),
        itemCount: tasks.length
    ),
    fallback: (context)=>Center(child: Container(child: Text('No tasks yet!'),)),
  );

