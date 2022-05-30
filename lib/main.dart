import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:universoprematurov8/pages/edit_profile.dart';

import 'models/route_gen.dart';
import 'pages/home.dart';
import 'pages/login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(MaterialApp(
    home: const Home(),
    theme: ThemeData(
      primaryColor: const Color.fromARGB(255, 255, 193, 143),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color.fromARGB(255, 255, 193, 143),
        secondary: const Color.fromARGB(255, 101, 187, 88)),
        elevatedButtonTheme: ElevatedButtonThemeData(style: TextButton.styleFrom(
          elevation: 20,
          shadowColor: Colors.black,
        ))
    ),
    initialRoute: "/",
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}