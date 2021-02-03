import 'package:flutter/material.dart';
import 'package:private_notes/components/base_login_screen.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();

  _cadastrar() {}

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
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Image.asset('assets/images/addImage.png'),
                      Padding(
                        child: Container(
                          child: Text(
                            'adicione uma foto ao seu perfil',
                            textAlign: TextAlign.center,
                          ),
                          width: MediaQuery.of(context).size.width * 0.5 - 60,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  )),
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
                padding: EdgeInsets.only(top: 50, bottom: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: _cadastrar,
                    child: Text('cadastrar'),
                    elevation: 0,
                  ),
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
