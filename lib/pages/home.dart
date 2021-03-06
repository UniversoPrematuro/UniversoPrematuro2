import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 5),
        child: Stack(children: <Widget>[
           Center(
             child: Image.asset(
               "images/logo/LogoMov.gif",
               width: 300,
             )
           ),
          Padding(
            padding: const EdgeInsets.only(top: 550, left: 50),
            child: ElevatedButton(
              onPressed: (){
                Navigator.pushReplacementNamed(context, "/login");
              },
              style: ButtonStyle(
                alignment: Alignment.center,
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 101, 187, 88)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14))),
                    minimumSize: MaterialStateProperty.all(const Size(75,40)),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0)
                    )
              ), 
              child: const Text("Já tem uma conta? Entre!", style: TextStyle(
                color: Colors.white, fontSize: 15
                    ),
                  ),
                )
              
            ),
            Padding(
              padding: const EdgeInsets.only(top: 610, left: 8),
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacementNamed(context, "/register");
                },
                style: ButtonStyle(
                  alignment: Alignment.center,
                  backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 255, 255)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  minimumSize: MaterialStateProperty.all(const Size(75,40)),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 12.5, horizontal: 40.0)),
                ),
                child: GestureDetector(
                  child: const Text(
                    "Primeira vez no Universo Prematuro?",
                    style: TextStyle(color: Color.fromARGB(255, 101, 187, 88), fontSize: 15),
                    )
                )


              ),
              
              )
          ]
        ),
      )
    );
  }
}