import 'package:flutter/material.dart';
import 'package:private_notes/components/buttons/custom_text_button.dart';
import 'package:private_notes/screens/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Open Sans',
          ),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Open Sans'),
          button: TextStyle(
            fontFamily: 'Open Sans',
            color: Colors.white,
          ),
        ),
        buttonColor: Color.fromRGBO(0xfb, 0x2f, 0x91, 1),
        buttonTheme: ButtonThemeData(
            buttonColor: Color.fromRGBO(0xfb, 0x2f, 0x91, 1),
            padding: EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textTheme: ButtonTextTheme.primary),
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '1',
              style: Theme.of(context).textTheme.headline4,
            ),
            RaisedButton(
              onPressed: () {
                debugPrint('clicou');
              },
              child: Text('123'),
            ),
            CustomTextButton(
              action: () {
                debugPrint('clicou no botão 2');
              },
              actionText: 'clique aqui',
              leftText: 'para uma melhor experiência ',
              rightText: '.',
            ),
          ],
        ),
      ),
    );
  }
}
