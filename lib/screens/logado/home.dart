import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:private_notes/components/buttons/custom_text_button.dart';
import 'package:private_notes/components/firebase_storage_image.dart';
import 'package:private_notes/screens/logado/perfil.dart';
import 'package:private_notes/screens/login_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final _titles = <Widget>[Text('tela 1'), Text('tela 2')];
  final _widgets = <Widget>[Text('tela 1'), Text('tela 2')];
  final _navigationItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.apps),
      label: 'público',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.lock),
      label: 'restrito',
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      this._selectedIndex = index;
    });
  }

  _openProfile() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Perfil(),
      ),
    );

    FirebaseAuth.instance.currentUser.reload();
  }

  _logout() {
    FirebaseAuth.instance.signOut().then(
          (value) => {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
                (route) => false),
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titles[this._selectedIndex],
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).buttonColor),
      ),
      body: Center(
        child: _widgets.elementAt(_selectedIndex),
      ),
      drawer: Drawer(
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  FirebaseStorageImage(
                    path: FirebaseAuth.instance.currentUser.uid,
                    width: 150,
                    height: 150,
                    borderRadius: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CustomTextButton(
                      action: _openProfile,
                      actionText: 'ver perfil',
                    ),
                  ),
                ],
              ),
              CustomTextButton(
                action: _logout,
                actionText: 'sair',
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).buttonColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
