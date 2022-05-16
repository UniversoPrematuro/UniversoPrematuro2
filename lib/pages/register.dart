import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
        backgroundColor: const Color.fromARGB(255, 255, 193, 143),
        elevation: 0,
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
                        children: const <Widget>[
                          TextField(
                            controller: null,
                            autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              fontSize: 20
                            ),
                            decoration: InputDecoration(
                              hintText: "E-mail",
                              prefixIcon: Icon(Icons.account_circle_outlined)),
                          ),
                          TextField(
                            controller: null,
                            autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              fontSize: 20
                            ),
                            decoration: InputDecoration(
                              hintText: "Senha",
                              prefixIcon: Icon(Icons.password)),
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