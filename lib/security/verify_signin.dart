import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:private_notes/screens/login_page.dart';

class VerifySignIn extends StatefulWidget {
  VerifySignIn({Key key, @required this.homePage}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final Widget homePage;

  @override
  _VerifySignInState createState() => _VerifySignInState();
}

class _VerifySignInState extends State<VerifySignIn> {
  bool isSignedIn = false;

  @override
  void initState() {
    super.initState();

    // FirebaseAuth.instance.authStateChanges().listen((User user) {
    //   if (user == null) {
    //     setState(() {
    //       this.isSignedIn = false;
    //     });
    //   } else {
    //     setState(() {
    //       this.isSignedIn = true;
    //     });
    //   }
    // });
    isSignedIn = FirebaseAuth.instance.currentUser == null;
  }

  @override
  Widget build(BuildContext context) {
    if (this.isSignedIn) {
      return LoginPage();
    }

    return this.widget.homePage;
  }
}
