// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:universoprematurov8/pages/login.dart';
import '../pages/edit_profile.dart';

// import 'home.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile>{

  String _emailUser = "";

  
  



 Future  _recuperarEmail() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = auth.currentUser!;

    setState(() {
      _emailUser = usuarioLogado.email!;
    });
  }

  @override
  void initState() {
    _recuperarEmail();
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: (){
             Navigator.pushReplacement(
               context, MaterialPageRoute(builder: (context) => const Login())
               
               );
          },
        ),
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
                    Container(
                      padding: const EdgeInsets.all(16),
                    ),
                      const CircleAvatar(
                        radius: 75,
                        backgroundColor: Colors.black,
                      ),
                  ],
                ),
              ),
              
              )
          )
        ]
        
      ));
  }
}