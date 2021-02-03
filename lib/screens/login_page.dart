import 'package:flutter/material.dart';
import 'package:private_notes/components/base_login_screen.dart';
import 'package:private_notes/components/buttons/custom_text_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  void _esqueciMinhaSenha() {}

  void _acesse() {}

  void seCadastre() {}

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
                decoration: const InputDecoration(
                  hintText: 'seu@email.com',
                ),
                validator: (value) {
                  var regex = RegExp(
                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
                  );
                  final v = regex.allMatches(value).isEmpty;
                  debugPrint(v.toString());
                  if (regex.allMatches(value).isEmpty) {
                    return 'email inválido';
                  }
                  return null;
                },
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
                decoration: const InputDecoration(
                  hintText: '******',
                ),
                validator: (value) {
                  if (value.length < 6) {
                    return 'A senha precisa de pelo menos 6 caracteres';
                  }
                  return null;
                },
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
                padding: EdgeInsets.only(top: 40, bottom: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: _acesse,
                    child: Text('acesse'),
                    elevation: 0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    CustomTextButton(
                      action: _esqueciMinhaSenha,
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
