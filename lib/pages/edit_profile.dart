// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/perfil_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerNomeMae = TextEditingController();
  final TextEditingController _controllerBirth = TextEditingController();
  final TextEditingController _controllerGage = TextEditingController();
  final TextEditingController _controllerGender = TextEditingController();
  var maskDate = MaskTextInputFormatter(
  mask: '##/##/####', 
  filter: { "#": RegExp(r'[0-9]') },
  type: MaskAutoCompletionType.lazy
  );
  var maskGage = MaskTextInputFormatter(
  mask: 'Semanas: ##, Dias: ##', 
  filter: { "#": RegExp(r'[0-9]') },
  type: MaskAutoCompletionType.lazy
);

  String _emailUser = "";


 Future  _recuperarEmail() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = auth.currentUser!;

    setState(() {
      _emailUser = usuarioLogado.email!;
    });
  }
  FirebaseStorage storage = FirebaseStorage.instance;
  XFile? _imagem;
  String? _idUsuarioLogado;
  bool _subindoImagem = false;
  String _urlImagemRecuperada = "";
  String mensagem = "";
 
  Future _recuperarImagem(String origemImagem) async {
    final ImagePicker _picker = ImagePicker();
    XFile? imagemSelecionada;
    FirebaseStorage storage = FirebaseStorage.instance;
    if (origemImagem == "camera") {
      imagemSelecionada = await _picker.pickImage(source: ImageSource.camera);
      setState(() {
        _imagem = imagemSelecionada;
        if (_imagem != null) {
          _uploadImagem();
          _subindoImagem = true;
        }
      });
    } else if (origemImagem == "galeria") {
      imagemSelecionada = await _picker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _imagem = imagemSelecionada;
      if (_imagem != null) {
        _uploadImagem();
        _subindoImagem = true;
      }
    });
  }
 
  Future _uploadImagem() async {
    File file = File(_imagem!.path);
    Reference pastaRaiz = await storage.ref();
    Reference arquivo =
    await pastaRaiz.child("perfil").child("${_idUsuarioLogado!}.jpg");
 
    UploadTask task = arquivo.putFile(file);
 
    task.snapshotEvents.listen((TaskSnapshot storageEvent) {
      if (storageEvent.state == TaskState.running) {
        setState(() {
          _subindoImagem = true;
        });
      } else if (storageEvent.state == TaskState.success) {
        setState(() {
          _subindoImagem = false;
        });
      }
    });
 
    task.then((TaskSnapshot taskSnapshot) => _recuperarURLimagem(taskSnapshot));
  }
 
  Future _recuperarURLimagem(TaskSnapshot taskSnapshot) async {
    String url =  await taskSnapshot.ref.getDownloadURL();
    setState(() {
      _urlImagemRecuperada = url;
    });
  }
  
  
   _atualizarNomeFirestore(){

     String nome = _controllerNome.text;
     
     FirebaseFirestore db = FirebaseFirestore.instance;

     Map<String, dynamic> dadosAtualizar = {
       "nome" : nome,
     };

     db.collection("users")
         .doc(_idUsuarioLogado)
         .update( dadosAtualizar );

   }

  saveData()async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = auth.currentUser!;
    _idUsuarioLogado = usuarioLogado.uid;
    
    FirebaseFirestore db = FirebaseFirestore.instance;
    String email = _emailUser;
    String nome = _controllerNome.text;
    String nomeMae = _controllerNomeMae.text;
    String birth = _controllerBirth.text;
    String gender = _controllerGender.text;
     String gage = _controllerGage.text;


    Map<String,dynamic> data = {
      "nome" : nome,
      "mae" : nomeMae,
      "nascimento" : birth,
      "genero" : gender,
       "gage" : gage,
    };
    db.collection("users").doc(_idUsuarioLogado).update(data);
    
  }

  _recuperaGage(){
    num gage = int.parse(_controllerGage.text.substring(9,11))*7 +
              int.parse(_controllerGage.text.substring(20,21));
    FirebaseFirestore db = FirebaseFirestore.instance;
    Map<String, num> gAge = {
      "gage" : gage
    };
    db.collection("users").doc(_idUsuarioLogado).update(gAge);
  }

  //  Future idadeReal(gage)async{
  //    int gage = int.parse(_controllerGage.text.substring(9,11))*7 +
  //              int.parse(_controllerGage.text.substring(20,21));
  //  }

  _atualizarUrlImagemFirestore(String url){

    FirebaseFirestore db = FirebaseFirestore.instance;

    Map<String, dynamic> dadosAtualizar = {
      "urlImagem" : url
    };
    
    db.collection("users")
    .doc(_idUsuarioLogado)
    .update( dadosAtualizar );

  }

  _recuperarDadosUsuario() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser!;
    _idUsuarioLogado = usuarioLogado.uid;

    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot snapshot = await db.collection("users")
      .doc( _idUsuarioLogado )
      .get();

    Map<String, dynamic>? dados = snapshot.data() as Map<String, dynamic>?;
    _controllerNome.text = dados!["nome"];

    if( dados["urlImagem"] != null ){
      _urlImagemRecuperada = dados["urlImagem"];
    }

  }
  
  
 


  @override
  void initState() {
    super.initState();
    saveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Perfil"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 193, 143),
        elevation: 0,
        actions: [Image.asset('images/logo/LogoTop.png', width: 45, height: 20)],
      ),
      body: Container(
        decoration:
          const BoxDecoration(color: Color.fromARGB(255, 255, 193, 143)),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                  _urlImagemRecuperada != null
                      ? NetworkImage(_urlImagemRecuperada) 
                      : null),
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: _subindoImagem ? const CircularProgressIndicator(color: Colors.green,) : Container()
                      )
                ,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      child: const Text("Câmera", style: TextStyle(color: Colors.green)),
                      onPressed: () {
                        _recuperarImagem("camera");
                      },
                    ),
                    TextButton(
                      child: const Text("Galeria", style: TextStyle(color: Colors.green)),
                      onPressed: () {
                        _recuperarImagem("galeria");
                      },
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
                          inputFormatters: [maskDate],
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
                          inputFormatters: [maskGage],
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
                      onPressed: () {
                        saveData();
                        _atualizarNomeFirestore();
                        _recuperaGage();
                        _atualizarUrlImagemFirestore(_urlImagemRecuperada);
                         Navigator.pushReplacementNamed(context, "/profile");
                      },
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