import 'usuario_model.dart';

class Perfil extends Usuario{
  

  String? _nome;
  String? _nomeMae;
  String? _birth;
  int? _gage;
  bool? _gender;

  Perfil();



  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
    "nome" : nome,
    "nome da mae" : nomeMae,
    "data de nasc." : birth,
    "idade" : gage,
    "sexo" : gender
    };
    return map;
  }

  String get nome => _nome!;

  set nome(String value){
    _nome = value;
  }

  String get nomeMae => _nomeMae!;

  set nomeMae(String value){
    _nomeMae = value;
  }

  String get birth => _birth!;

  set birth(String value){
    _birth = value;
  }

  int get gage => _gage!;

  set gage(int value){
    _gage = (value / 7) as int?;
  }

  bool get gender => _gender!;

  set gender(bool value){
    _gender = value;
  }
  

}