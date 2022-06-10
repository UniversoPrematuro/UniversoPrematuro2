import 'package:flutter/material.dart';

class Desenvolvimento extends StatefulWidget {
  Desenvolvimento({Key? key}) : super(key: key);

  @override
  State<Desenvolvimento> createState() => _DesenvolvimentoState();
}

class _DesenvolvimentoState extends State<Desenvolvimento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Desenvolvimento"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new), 
          onPressed: (){
            Navigator.pushReplacementNamed(context, "/profile");
            
            }),
      ),

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.red
        ),
        child: GridView.count(
          padding: EdgeInsets.all(10.0),
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: <Widget>[
            ElevatedButton(
              onPressed: (){
                Navigator.pushReplacementNamed(context, "/taskone");
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ))
                
                ),
              child: Text("1 - 3 Meses")
              
              ),
              ElevatedButton(
              onPressed: (){
                Navigator.pushReplacementNamed(context, "/tasktwo");
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ))
                
                ),
              child: Text("4 - 7 Meses")
              
              ),
              ElevatedButton(
              onPressed: (){},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ))
                
                ),
              child: Text("8 - 12 Meses")
              
              ),
              // ElevatedButton(
              // onPressed: (){},
              // style: ButtonStyle(
              //   backgroundColor: MaterialStateProperty.all(Colors.green),
              //   shape: MaterialStateProperty.all(RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(20)
              //   ))
                
              //   ),
              // child: Text("10 - 12 Meses")
              
              // ),
              // ElevatedButton(
              // onPressed: (){},
              // style: ButtonStyle(
              //   backgroundColor: MaterialStateProperty.all(Colors.green),
              //   shape: MaterialStateProperty.all(RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(20)
              //   ))
                
              //   ),
              // child: Text("9 - 12 Meses")
              
              // ),
          ],
        ),
        
        ),
    );
  }
}