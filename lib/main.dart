import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:private_notes/components/buttons/custom_text_button.dart';
import 'package:private_notes/screens/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Private Notes',
      theme: ThemeData(
        // Define the default brightness and colors.
        // brightness: Brightness.dark,
        // primaryColor: Color.fromRGBO(0xfb, 0x2f, 0x91, 1),
        primaryColor: Color.fromRGBO(0xfd, 0xfd, 0xfd, 1),
        accentColor: Color.fromARGB(0xfc, 0xd9, 0xea, 1),

        // Define the default font family.
        fontFamily: 'Open Sans',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(
            // fontSize: 72.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Open Sans',
          ),
          headline6: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Open Sans',
          ),
          bodyText1: TextStyle(fontSize: 18.0, fontFamily: 'Open Sans'),
          bodyText2: TextStyle(fontSize: 16.0, fontFamily: 'Open Sans'),
          button: TextStyle(
              fontFamily: 'Open Sans', color: Colors.white, fontSize: 18),
        ),
        buttonColor: Color.fromRGBO(0xfb, 0x2f, 0x91, 1),
        buttonTheme: ButtonThemeData(
          buttonColor: Color.fromRGBO(0xfb, 0x2f, 0x91, 1),
          padding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'ocorreu um problema inicializando o aplicativo...',
              ),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginPage();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Center(child: CircularProgressIndicator());
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

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

    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        setState(() {
          this.isSignedIn = false;
        });
      } else {
        setState(() {
          this.isSignedIn = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (this.isSignedIn) {
      return LoginPage();
    }

    return this.widget.homePage;
  }
}
