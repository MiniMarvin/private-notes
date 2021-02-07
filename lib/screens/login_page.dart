import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:private_notes/components/base_login_screen.dart';
import 'package:private_notes/components/buttons/custom_text_button.dart';
import 'package:private_notes/screens/cadastro.dart';
import 'package:private_notes/screens/logado/home.dart';
import 'package:private_notes/utils/dialog.dart';
import 'package:private_notes/utils/firebaseError.dart';
import 'package:private_notes/utils/validators.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  void _esqueciMinhaSenha() {
    // TODO: enviar para uma página de esqueci minha senha
  }

  void _acesse() {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      this.setState(() {
        this.loading = true;
      });
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: this.emailController.value.text,
              password: this.passwordController.value.text)
          .then((value) {
        debugPrint(value.toString());
        this.setState(() {
          this.loading = false;
        });

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home()),
          (route) => false,
        );
      }).catchError((Object error) {
        this.setState(() {
          this.loading = false;
        });
        debugPrint(error.toString());
        Map<String, String> dialogContent = handleFirebaseError(error);
        showAlertDialog(
          dialogContent['title'],
          dialogContent['content'],
          () {
            Navigator.of(context).pop();
          },
          context,
        );
      });
    }
  }

  void _cadastro() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Cadastro()),
    );
  }

  Widget _buildLoginButton() {
    if (this.loading == false) {
      return RaisedButton(
        onPressed: _acesse,
        child: Text('acesse'),
        elevation: 0,
      );
    }

    return RaisedButton(
      onPressed: () {},
      child: CircularProgressIndicator(),
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('tap');
        FocusScope.of(context).unfocus();
      },
      child: BaseLoginScreen(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 5),
                child: Row(
                  children: [
                    Text(
                      'email',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'seu@email.com',
                ),
                validator: (value) => validateEmail(value),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40, bottom: 5),
                child: Row(
                  children: [
                    Text(
                      'senha',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: '******',
                ),
                validator: (value) => validatePassword(value),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    CustomTextButton(
                      action: _esqueciMinhaSenha,
                      actionText: 'esqueci minha senha',
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: _buildLoginButton(),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    CustomTextButton(
                      action: _cadastro,
                      actionText: 'se cadastre',
                      leftText: 'ou ',
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ],
          ),
        ),
        title: 'o seu\ndiário secreto',
      ),
    );
  }
}
