class Usuario{
  String? _email;
  String? _passw;
  // String? _nome;
  // String? _nomeMae;
  // String? _birth;
  // int? _gage;
  // bool? _gender;


  Usuario();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {"email:": email};
    return map;
  }

  String get email => _email!;

  set email(String value){
    _email = value;
  }

  String get passw => _passw!;

  set passw(String value){
    _passw = value;
  }

}