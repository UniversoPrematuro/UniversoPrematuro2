// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:universoprematurov8/pages/login.dart';
import 'package:universoprematurov8/repositories/prof_rep.dart';
import '../models/perfil_model.dart';
import '../pages/edit_profile.dart';

// import 'home.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();

}

class _ProfileState extends State<Profile> with ProfileState{
 



  @override
  void initState() {    
    super.initState();
    instance.recuperarDadosUsuario();
  }


  @override
  Widget build(BuildContext context) {
    

    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
            height: MediaQuery.of(context).size.height / 3,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          children:  <Widget>[
                            Text('Nome: ${instance.controllerNome.text} ',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            Text('Mãe: ${instance.controllerNomeMae.text}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            Text('Aniversario: ${instance.controllerBirth.text}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            Text('Aniversario: ${instance.controllerGage.text}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                          
                          
                        ),
                      ),
                         Padding(
                           padding: EdgeInsets.only(/*left: 88, bottom: 200*/),
                           child: CircleAvatar(
                           radius: 55,
                           backgroundColor: Colors.black,
                           backgroundImage: NetworkImage(instance.urlImagemRecuperada),
                           ),
                         ),

                          
                         

                        //  Padding(
                        //    padding:  EdgeInsets.only( top: 120, right: 10),
                        //    child: OutlinedButton(
                        //        onPressed: (){
                        //            instance.recuperarDadosUsuario();
                        //            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  Lol()));
                        //          },
                        //        style: ButtonStyle(
                        //           side: MaterialStateProperty.all(const BorderSide(width: 0.75, color:  Color.fromARGB(255, 255, 255, 255),)),
                        //          backgroundColor: MaterialStateProperty.all(
                        //            const Color.fromARGB(0, 255, 255, 255)),
                        //            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        //              borderRadius: BorderRadius.circular(14))),
                        //              minimumSize: MaterialStateProperty.all(const Size(75,40)),
                        //              padding: MaterialStateProperty.all(
                        //                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0)
                        //              ),
                        //            ),
                        //        child: const Text("Editar Perfil", style: TextStyle(
                        //          color: Colors.white, fontSize: 15
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                          ],
                        ),
                      ]
                    ),
                  )
                )
              ),
              TabBar(
                padding: const EdgeInsets.only(bottom: 0),
               indicator:  UnderlineTabIndicator(
                 borderSide: BorderSide(width: 2.5, color: Colors.green),
                 insets: EdgeInsets.symmetric(horizontal: 30.0),
                 
               ),
               indicatorColor: Colors.green,
               tabs: [
                 Tab(text: "Fotos",),
                 Tab(text: "Videos",)
               ],
               
            ),
            SizedBox(
              height: 200,
              child: TabBarView(
                children: [
                  Container(child: Text('teste'),),
                  Container(child: Text('teste2'),)
                ],
              ),
              
            )
              
            ]
        
          )
        )
      );
  }
}

