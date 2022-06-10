import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universoprematurov8/pages/edit_profile.dart';
import 'package:universoprematurov8/pages/profile.dart';
import 'dart:io';
import '../models/perfil_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfState extends State<EditProfile> with RegisterValidator{

  final TextEditingController controllerNome = TextEditingController();
  final TextEditingController controllerNomeMae = TextEditingController();
  final TextEditingController controllerBirth = TextEditingController();
  final TextEditingController controllerGage = TextEditingController();
  final TextEditingController controllerGender = TextEditingController();
  String erro = "";


  var maskDate = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  var maskGage = MaskTextInputFormatter(
      mask: 'Semanas: ##, Dias: ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  static final ProfState instance = ProfState();

  String _emailUser = "";
  @override
  void initState() {
    (){
      FirebaseAuth auth = FirebaseAuth.instance;
      User usuarioLogado = auth.currentUser!;
      if(idUsuarioLogado == auth.currentUser!.uid){
        recuperarDadosUsuario();
      }
    };
    urlImagemRecuperada;
    super.initState();
  }

  

  Future _recuperarEmail() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = auth.currentUser!;

    setState(() {
      _emailUser = usuarioLogado.email!;
    });
  }

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

  //  _atualizarNomeFirestore(){

  //    String nome = _controllerNome.text;
  //    String nomeMae = _controllerNomeMae.text;
  //   String birth = _controllerBirth.text;
  //   String gender = _controllerGender.text;
  //   int gage = int.parse(_controllerGage.text.substring(9,11))*7 +
  //             int.parse(_controllerGage.text.substring(20,31));

  //    FirebaseFirestore db = FirebaseFirestore.instance;

  //    Map<String, dynamic> dadosAtualizar = {
  //      "nome" : nome,
  //      "mae" : nomeMae,
  //     "nascimento" : birth,
  //     "genero" : gender,
  //      "gage" : gage
  //    };

  //    db.collection("users")
  //        .doc(_idUsuarioLogado)
  //        .update( dadosAtualizar );

  //  }

  Future trueGage() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    int gage = controllerGage.text as int;
    gage = gage * 7 + gage;
  }

  saveData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = auth.currentUser!;
    idUsuarioLogado = usuarioLogado.uid;

    FirebaseFirestore db = FirebaseFirestore.instance;
    String email = _emailUser;
    String nome = controllerNome.text;
    String nomeMae = controllerNomeMae.text;
    String birth = controllerBirth.text;
    String gender = controllerGender.text;
    String gage = controllerGage.text;

    

    Map<String, dynamic> data = {
      "nome": nome,
      "mae": nomeMae,
      "nascimento": birth,
      "genero": gender,
      "gage": gage
    };
    db.collection("users").doc(idUsuarioLogado).update(data);
    setState(() {
      nome = controllerNome.text;
      nomeMae = controllerNomeMae.text;
      birth = controllerBirth.text;
      gender = controllerGender.text;
      gage = controllerGage.text;
    });
  }

  atualizarUrlImagemFirestore(String url) {
    FirebaseFirestore db = FirebaseFirestore.instance;

    Map<String, dynamic> dadosAtualizar = {"urlImagem": url};

    db.collection("users").doc(idUsuarioLogado).update(dadosAtualizar);
    setState(() {
      urlImagemRecuperada = url;
    });
  }

  recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser!;
    idUsuarioLogado = usuarioLogado.uid;

    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await db.collection("users").doc(idUsuarioLogado).get();

    Map<String, dynamic>? dados = snapshot.data() as Map<String, dynamic>?;
    controllerNome.text = dados!["nome"];
    controllerNomeMae.text = dados["mae"];
    controllerBirth.text = dados["nascimento"];
    controllerGender.text = dados["genero"];
    controllerGage.text = dados["gage"];

    if (dados["urlImagem"] != null) {
      urlImagemRecuperada = dados["urlImagem"];
    }
    // setState(() {
    //   String nome = controllerNome.text;
    //   String nomeMae = controllerNomeMae.text;
    //   String birth = controllerBirth.text;
    //   String gender = controllerGender.text;
    //   String gage = controllerGage.text;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

mixin ProfileState {
  var instance = ProfState();
  Future setDados() async {
    var dados = instance.saveData();
  }

  Future photo() async {
    var foto = instance.urlImagemRecuperada;
  }
}