import 'package:flutter/material.dart';

class TaskOne extends StatefulWidget {
  TaskOne({Key? key}) : super(key: key);

  @override
  State<TaskOne> createState() => _TaskOneState();
}

class _TaskOneState extends State<TaskOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
            title: const Text("Primeiros meses"),
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
          ,
        ),
      body: Container(
        padding: const EdgeInsets.all(0),
        child: Center(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 35,
            crossAxisSpacing: 25,
            children: <Widget>[
              ElevatedButton(onPressed: (){}, child: Text("Tarefa 1")),
               ElevatedButton(onPressed: (){}, child: Text("Tarefa 1")),
                ElevatedButton(onPressed: (){}, child: Text("Tarefa 1")),
                 ElevatedButton(onPressed: (){}, child: Text("Tarefa 1")),
                  ElevatedButton(onPressed: (){}, child: Text("Tarefa 1")),
                   ElevatedButton(onPressed: (){}, child: Text("Tarefa 1")),
                    ElevatedButton(onPressed: (){}, child: Text("Tarefa 1")),
                     ElevatedButton(onPressed: (){}, child: Text("Tarefa 1")),
                      ElevatedButton(onPressed: (){}, child: Text("Tarefa 1")),
                       ElevatedButton(onPressed: (){}, child: Text("Tarefa 1"))
            ],
          )
        ),
      ),
    );
  }
}