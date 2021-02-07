import 'package:flutter/material.dart';

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

  _openMenu() {
    debugPrint('menu open');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titles[this._selectedIndex],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: _openMenu,
            color: Theme.of(context).buttonColor,
          ),
        ],
      ),
      body: Center(
        child: _widgets.elementAt(_selectedIndex),
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
