import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerNomeMae = TextEditingController();
  final TextEditingController _controllerBirth = TextEditingController();
  final TextEditingController _controllerGage = TextEditingController();
  final TextEditingController _controllerGender = TextEditingController();
  
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Perfil"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 193, 143),
        elevation: 0,
        actions: [Image.asset('images/logo/LogoTop.png', width: 45, height: 20)],
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_new),
        //   onPressed: (){
        //      Navigator.pushReplacement(
        //        context, MaterialPageRoute(builder: (context) => const Home())
               
        //        );
        //   },
        // ),
      ),
      body: Container(
        decoration:
          const BoxDecoration(color: Color.fromARGB(255, 255, 193, 143)),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const CircleAvatar(
                     radius: 100,
                     backgroundImage: null,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      child: const Text("Câmera"),
                      onPressed: () {},
                    ),
                    TextButton(
                      child: const Text("Galeria"),
                      onPressed: () {},
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: TextField(
                          controller: _controllerNome,
                          autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                            fontSize: 20
                          ),
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white
                            )
                          ),
                            hintText: "Nome",
                            labelText: "Nome",
                            prefixIcon: Icon(Icons.person_add_alt_outlined, color: Colors.green,)),
                        ),
                ),
                const SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: TextField(
                          controller: _controllerNomeMae,
                          autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                            fontSize: 20
                          ),
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white
                            )
                          ),
                            hintText: "Nome da mãe",
                            labelText: "Nome da mãe",
                            prefixIcon: Icon(Icons.person_add_alt_outlined, color: Colors.green,)),
                        ),
                ),
                const SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: TextField(
                          controller: _controllerBirth,
                          autofocus: true,
                          keyboardType: TextInputType.datetime,
                          style: const TextStyle(
                            fontSize: 20
                          ),
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white
                            )
                          ),
                              hintText: 'DD/MM/AAAA',
                              labelText: 'Data de Nascimento',
                            prefixIcon: Icon(Icons.calendar_month_outlined, color: Colors.green,)),
                        ),
                ),
                const SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: TextField(
                          controller: _controllerGage,
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 20
                          ),
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white
                            )
                          ),
                            hintText: 'Semanas: SS e Dias: D',
                            labelText: 'Idade Gestacional',
                            prefixIcon: Icon(Icons.calendar_month_outlined, color: Colors.green,)),
                        ),
                ),
                const SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: TextField(
                          controller: _controllerGender,
                          autofocus: true,
                          keyboardType: TextInputType.name,
                          style: const TextStyle(
                            fontSize: 20
                          ),
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white
                            )
                          ),
                            hintText: "Sexo",
                            labelText: "Sexo",
                            prefixIcon: Icon(Icons.person_add_alt_1_outlined, color: Colors.green,)),
                        ),
                ),
                const SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(22, 12, 22, 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22)),
                          backgroundColor:
                              const Color.fromARGB(255, 101, 187, 88)),
                      child: const Text(
                        "Salvar dados",
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    )
                  ),
              ]
            )
          )
        )
      )
    );
  }
}