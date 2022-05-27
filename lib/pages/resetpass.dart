import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _controllerEmail = TextEditingController();

  changePass(){
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = auth.currentUser!;
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Esqueci minha senha"), 
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 193, 143),
        elevation: 0,
        actions: [Image.asset('images/logo/LogoTop.png', width: 45, height: 20)],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: (){
             Navigator.pushReplacement(
               context, MaterialPageRoute(builder: (context) => const Login())
               
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Image.asset("images/logo/LogoMov.gif", width: 250, height: 180),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    elevation: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(50),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Você esqueceu sua senha? \nNão se preocupe, não há problema!\nNós iremos te ajudar a recupera-la, para isso, "
                            "precisaremos do seu e-mail, insira-o no campo abaixo: ",
                            textAlign: TextAlign.center,
                             style: TextStyle(
                               fontSize: 14,
                               fontWeight: FontWeight.w500,
                               color: Colors.green
                               ),
                              ),
                          const SizedBox(
                            height: 20
                          ),
                          TextField(
                            controller: _controllerEmail,
                            autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(fontSize: 15),
                            decoration:  InputDecoration(
                              floatingLabelAlignment: FloatingLabelAlignment.center,
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 5,
                                  color: Colors.green
                                )
                              ),
                              hintText: "E-mail",
                              hintStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500
                              ),
                              alignLabelWithHint: true,
                              prefixIcon: const Icon(Icons.email_outlined, color: Colors.green)
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 55),
                            child: ElevatedButton(
                              onPressed: (){
                                FirebaseAuth.instance
                                .sendPasswordResetEmail(email: _controllerEmail.text)
                                .then((value) => Navigator.pushReplacementNamed(context, "/login"));

                              },
                              style: ButtonStyle(
                                alignment: Alignment.center,
                                backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 101, 187, 88)
                                ),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                minimumSize: MaterialStateProperty.all(const Size(70, 40)),
                                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 10, horizontal: 40))
                              ),
                              child: const Text("Recuperar senha"),
                            ),
                            
                            )
                        ]
                      )
                    ),
                  )
                ],
              )
            )
          )
        )
    );
  }
}