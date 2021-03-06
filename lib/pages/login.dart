// ignore_for_file: use_build_context_synchronously, await_only_futures, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/usuario_model.dart';
import '../pages/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassw = TextEditingController();
  var _errorMessage = "";


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
        _logarUsuario( usuario );

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



  _logarUsuario(Usuario usuario){
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(email: usuario.email, password: usuario.passw)
    .then((firebaseUser){

      Navigator.pushReplacementNamed(context, "/profile");

    }).catchError((error){
      setState(() {
        _errorMessage = "Erro ao autenticar o usuario, verifique email e senha";
      });
    }
    
    );

  }

  Future _verificaLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;


    User usuarioLogado = await auth.currentUser!;
    if(usuarioLogado != null ){
      Navigator.pushReplacementNamed(context, "/profile");
    }

  }

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"), 
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
          color: Color.fromARGB(255, 255, 193, 143)),
          padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Image.asset("images/logo/logologin.png", width: 200, height: 150),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
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
                          style: const TextStyle(fontSize: 20),
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green
                              )
                            ),
                            hintText: "E-mail",
                            prefixIcon: Icon(Icons.account_circle_outlined, color: Colors.green,)),
                        ),
                        const SizedBox(height: 20.0),
                        TextField(
                          controller: _controllerPassw,
                          autofocus: true,
                          obscureText: true,
                          style: const TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green
                              )
                            ),
                            alignLabelWithHint: mounted,
                            hintText: "Senha",
                            prefixIcon: const Icon(Icons.password_rounded, color: Colors.green,), 
                            ),
                        ),
                        const SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 10),
                          child: ElevatedButton(
                            onPressed: (){
                              if(_validarCampos() == true){
                                _logarUsuario(Usuario());
                                Navigator.pushReplacementNamed(context, "/profile");
                              }
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
                            child: const Text("Entre agora!", style: TextStyle(
                              color: Colors.white, fontSize: 15
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 1),
                          child: Center(
                            child: Text(
                              _errorMessage, 
                              style: const 
                              TextStyle(
                                color: Color.fromARGB(255, 255, 0, 0),
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 10),
                          child: OutlinedButton(
                            onPressed: (){
                              Navigator.pushReplacementNamed(context, "/resetpassword");
                            },
                            
                            style:  ButtonStyle(
                              
                              side: MaterialStateProperty.all(const BorderSide(width: 1.5, color: Colors.green, style: BorderStyle.solid)),
                              alignment: Alignment.center,
                              backgroundColor: MaterialStateProperty.all(const Color.fromARGB(0, 0, 0, 0)),
                            
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            )),

                            minimumSize: MaterialStateProperty.all(const Size(50,25)),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 8, horizontal: 40)

                            )
                              ),

                            child: const Text(
                              "Esqueceu sua senha?", 
                              style: TextStyle(
                                color: Colors.green, fontSize: 15, fontWeight: FontWeight.bold
                              )
                            )
                          ),
                          
                          )
                      ],
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}