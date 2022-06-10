import 'package:flutter/material.dart';

class TaskTwo extends StatefulWidget {
  TaskTwo({Key? key}) : super(key: key);

  @override
  State<TaskTwo> createState() => _TaskTwoState();
}

class _TaskTwoState extends State<TaskTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
            title: const Text("Tarefa  2"),
            backgroundColor: Colors.green,
            centerTitle: true,
            elevation: 2,
            leading: IconButton(
              icon:const Icon(Icons.arrow_back_ios_new_outlined),
              onPressed: (() {
                Navigator.pushReplacementNamed(context, "/desenvolvimento");

                }
              )
            )
        ),

      body: Center(child: Text("Task 2")),
    );
  }
}