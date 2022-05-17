import 'package:flutter/material.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: const Color.fromARGB(255, 101, 187, 88),
        centerTitle: true,
        elevation: 2,
      ),
      body: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 193, 143),
          ),
        )
      );
  }
}