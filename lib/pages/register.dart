// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/perfil_model.dart';

import '../models/usuario_model.dart';
import 'edit_profile.dart';
import 'home.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}



class _RegisterState extends State<Register> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassw = TextEditingController();
  String _errorMessage = "";

  _logarUsuario(Usuario usuario){
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(email: usuario.email, password: usuario.passw)
    .then((firebaseUser){

      Navigator.pushReplacementNamed(context, "/nav");

    }).catchError((error){
      setState(() {
        _errorMessage = "Erro ao autenticar o usuario, verifique email e senha";
      });
    }
    
    );

  }

  _validarCampos(){
    String email = _controllerEmail.text;
    String passw = _controllerPassw.text;

    if(email.isNotEmpty && email.contains("@")){
      if(passw.isNotEmpty && passw.length >= 5){
        setState(() {
          _errorMessage = "";
        });

        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.passw = passw;
        _cadastrarUsuario( usuario );

      } else{
        setState(() {
          _errorMessage = "Preencha a senha corretamente";
        });
      }

    } else {
      setState(() {
        _errorMessage = "Preencha o email";
      });
    }
  }

  

  _cadastrarUsuario( Usuario usuario ){
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(
      email: usuario.email, password: usuario.passw
      ).then((firebaseUser){
        FirebaseFirestore db = FirebaseFirestore.instance;

        db.collection("users").doc(firebaseUser.user?.uid).set(usuario.toMap());

        setState(() {
          _errorMessage = "Usuário cadastrado com sucesso!";
        });
      }).catchError((error){
        print("erro app: $error" );
        setState(() {
          _errorMessage = "Erro ao cadastrar usuário, verifique todos os campos";
        });
      }

      );
    

    
  }



  
    
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 193, 143),
        elevation: 0,
        actions: [Image.asset('images/logo/LogoTop.png', width: 45, height: 20)],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: (){
             Navigator.pushReplacement(
               context, MaterialPageRoute(builder: (context) => const Home())
               
               );
          },
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 193, 143)
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            // controller: controller,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Image.asset("images/logo/logologin.png",width: 200, height: 150),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    ),
                    elevation: 16,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextField(
                            controller: _controllerEmail,
                            autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                              fontSize: 20
                            ),
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green
                              )
                            ),
                              hintText: "E-mail",
                              prefixIcon: Icon(Icons.account_circle_outlined, color: Colors.green,)),
                          ),
                          TextField(
                            controller: _controllerPassw,
                            autofocus: true,
                            obscureText: true,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                              fontSize: 20
                            ),
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green
                              )
                            ),
                              hintText: "Senha",
                              prefixIcon: Icon(Icons.password, color: Colors.green,)),
                          ),
                    Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: ElevatedButton(
                      onPressed: () {
                        if(_validarCampos() != true){
                          _errorMessage;
                        } else {
                          _cadastrarUsuario(Usuario());
                          _logarUsuario(Usuario());
                        }
                          Navigator.pushReplacementNamed(context, "/editprofile");
                        
                      },
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(22, 12, 22, 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22)),
                          backgroundColor:
                              const Color.fromARGB(255, 101, 187, 88)),
                      child: const Text(
                        "Cadastrar",
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    )
                  ),
                          Center(
                            child: Text(
                              _errorMessage, 
                              style: const 
                              TextStyle(
                                color: Color.fromARGB(255, 255, 0, 0)
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
        )
      ),
    );
  }
}