import 'package:flutter/material.dart';
import 'package:universoprematurov8/pages/edit_profile.dart';
import 'package:universoprematurov8/pages/profile.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {

  int opcaoS = 0;
  List<Widget> pages = <Widget>[
    Profile(),
    EditProfile()
  ];

  void onTapped(int index){
    setState(() {
      opcaoS = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              currentIndex: opcaoS,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home,),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Editar Perfil",
                  
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.developer_board),
                  label: "Desenvolvimento"
                  
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_upward),
                  label: "Crescimento",
                  
                ),
                
              ],
              onTap: onTapped,
            ),

            body: Center(child: pages.elementAt(opcaoS))
    );
  }
}

