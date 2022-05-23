import 'usuario_model.dart';

class Perfil extends Usuario{
  

  String? _nome;
  String? _nomeMae;
  String? _birth;
  int? _gage;
  bool? _gender;

  Perfil();



  @override
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

  @override
  String get nome => _nome!;

  @override
  set nome(String value){
    _nome = value;
  }

  @override
  String get nomeMae => _nomeMae!;

  @override
  set nomeMae(String value){
    _nomeMae = value;
  }

  @override
  String get birth => _birth!;

  @override
  set birth(String value){
    _birth = value;
  }

  @override
  int get gage => _gage!;

  @override
  set gage(int value){
    _gage = (value / 7) as int?;
  }

  @override
  bool get gender => _gender!;

  @override
  set gender(bool value){
    _gender = value;
  }
  

}