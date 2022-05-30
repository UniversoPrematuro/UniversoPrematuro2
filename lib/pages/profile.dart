// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:universoprematurov8/pages/login.dart';
import '../models/perfil_model.dart';
import '../pages/edit_profile.dart';

// import 'home.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();

}

class _ProfileState extends State<Profile>{

  String? _idUsuarioLogado;

  


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 2,
      
        actions: [IconButton(
          icon:const Icon(Icons.door_back_door_outlined),
          onPressed: (() {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, "/login");

            }
          )
        )
      ],
    ),

       body: Column(
        children: <Widget>[
          Container(
          
            
            padding: const EdgeInsets.only(top: 16),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            decoration: const BoxDecoration(

              color: Colors.green,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(32),
                  bottomLeft: Radius.circular(32)),
            ),
            
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          children: const <Widget>[
                            Text('Nome: ',
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                            Text('12',
                              style: TextStyle(
                                color: Colors.white
                              ),
                            )
                          ],
                        ),
                      ),
                    
                    
                         const Padding(
                           padding: EdgeInsets.only(left: 88, bottom: 50),
                           child: CircleAvatar(
                           radius: 55,
                           backgroundColor: Colors.black,
                           ),
                         ),
                      
                      Padding(
                        padding:  EdgeInsets.only( top: 120, right: 10),
                        child: OutlinedButton(
                            onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const EditProfile()));
                              },
                            style: ButtonStyle(
                               side: MaterialStateProperty.all(const BorderSide(width: 0.75, color:  Color.fromARGB(255, 255, 255, 255),)),
                              backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(0, 255, 255, 255)),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14))),
                                  minimumSize: MaterialStateProperty.all(const Size(75,40)),
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0)
                                  ),
                                ),
                            child: const Text("Editar Perfil", style: TextStyle(
                              color: Colors.white, fontSize: 15
                              ),
                            ),
                          ),
                      ),
                  ],
                ),
                  ]
              ),
            )
          )
          )
        ]
        
      ));
  }
}

