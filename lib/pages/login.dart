import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassw = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            iconColor: Color.fromARGB(255, 101, 187, 88),
                            hintText: "E-mail",
                            prefixIcon: Icon(Icons.account_circle_outlined)),
                        ),
                        const SizedBox(height: 20.0),
                        TextField(
                          controller: _controllerPassw,
                          autofocus: true,
                          obscureText: true,
                          style: const TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            alignLabelWithHint: mounted,
                            hintText: "Senha",
                            prefixIcon: const Icon(Icons.password_rounded)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 10),
                          child: ElevatedButton(
                            onPressed: (){},
                            child: const Text("Cadastrar!", style: TextStyle(
                              color: Colors.white, fontSize: 15
                            ),),
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