import 'package:flutter/material.dart';
import 'package:private_notes/components/base_login_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BaseLoginScreen(child: Container(), title: 'o seu\ndiário secreto');
  }
}