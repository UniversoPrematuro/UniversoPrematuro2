// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universoprematurov8/pages/profile.dart';
import 'package:universoprematurov8/repositories/prof_rep.dart';
import 'dart:async';
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}




class RegisterValidator{

  final validateName = StreamTransformer<String,String>.fromHandlers(
      handleData: (name,sink){
        if(name.length >= 5){
          sink.add(name);
        } else {
          sink.addError('Digite um nome válido');
        }
      }
  );
  final validateBirth = StreamTransformer<String,String>.fromHandlers(
      handleData: (birth,sink){
        if(birth.length == 10){
          int d = int.parse(birth.substring(0,2));
          int m = int.parse(birth.substring(3,5));
          int y = int.parse(birth.substring(6,10));
          if(d >= 1 && d <= 31 && m >= 1 && m <=12 && y >= 2019){
            sink.add(birth);
          }else {
            sink.addError('Digite uma data válida');
          }
        } else {
          sink.addError('Digite a data completa');
        }
      }
  );
  final validateMother = StreamTransformer<String,String>.fromHandlers(
      handleData: (mother,sink){
        if(mother.length >= 5){
          sink.add(mother);
        } else {
          sink.addError('Digite um nome válido');
        }
      }
  );
  final validateGage = StreamTransformer<String,String>.fromHandlers(
      handleData: (gage,sink){
        if(gage.length == 21){
          int s = int.parse(gage.substring(9,11));
          int d = int.parse(gage.substring(20,21));
          if(s >= 22 && s <= 37 && d <= 6){
            sink.add(gage);
          }else {
            sink.addError('Digite valores válidos');
          }
        } else {
          sink.addError('Digite as semanas e os dias');
        }
      }
  );
  // final validateGender = StreamTransformer<String,String>.fromHandlers(
  //     handleData: (gender,sink){
  //       if(gender == 'Masculino' || gender == 'Feminino'){
  //         sink.add(gender);
  //       } else {
  //         sink.addError('Selecione uma opção');
  //       }
  //     }
  // );

  // final validateCell =  StreamTransformer<String,String>.fromHandlers(
  //   handleData: (cell, sink) {
  //     if(cell.length > 8 && cell.length < 15){
  //       sink.add(cell);
  //     } else {
  //       sink.addError('Digite o número corretamente');
  //     }
  //   }
  // );

  // final validateCellButton = StreamTransformer<String,bool>.fromHandlers(
  //   handleData: (cell,sink) {
  //     if(cell.length > 8 && cell.length < 15){
  //       sink.add(true);
  //     } else {
  //       sink.add(false);
  //     }
  //   }
  // );

}
class _EditProfileState extends State<EditProfile> with ProfileState, RegisterValidator{

  
  
  
  
  
  FirebaseStorage storage = FirebaseStorage.instance;
  XFile? imagem;
  String? idUsuarioLogado;
  bool subindoImagem = false;
  String urlImagemRecuperada = "";
  String mensagem = "";

  Future recuperarImagem(String origemImagem) async {
    final ImagePicker _picker = ImagePicker();
    XFile? imagemSelecionada;
    FirebaseStorage storage = FirebaseStorage.instance;
    if (origemImagem == "camera") {
      imagemSelecionada = await _picker.pickImage(source: ImageSource.camera);
      setState(() {
        imagem = imagemSelecionada;
        if (imagem != null) {
          uploadImagem();
          subindoImagem = true;
        }
      });
    } else if (origemImagem == "galeria") {
      imagemSelecionada = await _picker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      imagem = imagemSelecionada;
      if (imagem != null) {
        uploadImagem();
        subindoImagem = true;
      }
    });
  }

  Future uploadImagem() async {
    File file = File(imagem!.path);
    Reference pastaRaiz = await storage.ref();
    Reference arquivo =
        await pastaRaiz.child("perfil").child("${idUsuarioLogado!}.jpg");

    UploadTask task = arquivo.putFile(file);

    task.snapshotEvents.listen((TaskSnapshot storageEvent) {
      if (storageEvent.state == TaskState.running) {
        setState(() {
          subindoImagem = true;
        });
      } else if (storageEvent.state == TaskState.success) {
        setState(() {
          subindoImagem = false;
        });
      }
    });

    task.then((TaskSnapshot taskSnapshot) => recuperarURLimagem(taskSnapshot));
  }

  Future recuperarURLimagem(TaskSnapshot taskSnapshot) async {
    String url = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      urlImagemRecuperada = url;
    });
  }

  @override
  void initState() {
    instance.recuperarDadosUsuario();
    urlImagemRecuperada;
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Editar Perfil"),
          centerTitle: true,
          backgroundColor:  Colors.green,
          elevation: 0,
          actions: [
            Image.asset('images/logo/LogoTop.png', width: 45, height: 20)
          ],
        ),
        body: Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 255, 193, 143)),
            padding: const EdgeInsets.all(16),
            child: Center(
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(),
                  child: subindoImagem
                      ? const CircularProgressIndicator(
                          color: Colors.green,
                        )
                      : Container()),
              CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  backgroundImage: urlImagemRecuperada != null
                      ? NetworkImage(urlImagemRecuperada)
                      : null),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    child: const Text("Câmera",
                        style: TextStyle(color: Colors.green)),
                    onPressed: () {
                      recuperarImagem("camera");
                    },
                  ),
                  TextButton(
                    child: const Text("Galeria",
                        style: TextStyle(color: Colors.green)),
                    onPressed: () {
                      recuperarImagem("galeria");
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: TextField(
                  controller: instance.controllerNome,
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: "Nome",
                      labelText: "Nome",
                      prefixIcon: Icon(
                        Icons.person_add_alt_outlined,
                        color: Colors.green,
                      )),
                ),
              ),
              const SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: TextField(
                  controller: instance.controllerNomeMae,
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: "Nome da mãe",
                      labelText: "Nome da mãe",
                      prefixIcon: Icon(
                        Icons.person_add_alt_outlined,
                        color: Colors.green,
                      )),
                ),
              ),
              const SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: TextField(
                  inputFormatters: [instance.maskDate],
                  controller: instance.controllerBirth,
                  autofocus: true,
                  keyboardType: TextInputType.datetime,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: 'DD/MM/AAAA',
                      labelText: 'Data de Nascimento',
                      prefixIcon: Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.green,
                      )),
                ),
              ),
              const SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: TextField(
                  controller: instance.controllerGage,
                  inputFormatters: [instance.maskGage],
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: 'Semanas: SS e Dias: D',
                      labelText: 'Idade Gestacional',
                      prefixIcon: Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.green,
                      )),
                ),
              ),
              const SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: TextField(
                  controller: instance.controllerGender,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: "Sexo",
                      labelText: "Sexo",
                      prefixIcon: Icon(
                        Icons.person_add_alt_1_outlined,
                        color: Colors.green,
                      )),
                ),
              ),
              const SizedBox(height: 5.0),
              Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: ElevatedButton(
                    onPressed: () {
                      instance.saveData();
                      instance.recuperarDadosUsuario();
                      // instance.atualizarUrlImagemFirestore(urlImagemRecuperada);
                       Navigator.pushReplacementNamed(context, '/profile');
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
                    },
                    
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(22, 12, 22, 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22)),
                        backgroundColor:
                            const Color.fromARGB(255, 101, 187, 88)),
                    child: const Text(
                      "Salvar dados",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
                  Center(
                            child: Text(
                              instance.erro, 
                              style: const 
                              TextStyle(
                                color: Color.fromARGB(255, 255, 0, 0)
                              ),
                            ),
                          )
            ],

          ),
        )
      ),
    ));
  }
}

// mixin EditProfileState {
//   var instance = _EditProfileState();
//   Future recupera() async {
//     String nome = instance.controllerNome.text;
//     String nomeMae = instance.controllerNomeMae.text;
//     String birth = instance.controllerBirth.text;
//     String gender = instance.controllerGender.text;
//   }

//   Future imagem() async {
//     String image = instance.urlImagemRecuperada;
//   }
// }