import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConfirmarContaInput extends StatefulWidget {
  @override
  _ConfirmarContaInputState createState() => _ConfirmarContaInputState();
}

class _ConfirmarContaInputState extends State<ConfirmarContaInput> {
  final _formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();
  bool loading = false;

  validateCodeInput(String code) {
    if (code == null || code.isEmpty) {
      return 'o código não pode estar vazio';
    }
  }

  _validateCode() {
    FirebaseAuth.instance.currentUser;
  }

  Widget _buildLoginButton() {
    if (this.loading == false) {
      return RaisedButton(
        onPressed: _validateCode,
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
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: <Widget>[
            Text('código de confirmação'),
            TextFormField(
              controller: codeController,
              decoration: const InputDecoration(
                hintText: '123456',
              ),
              validator: (value) => validateCodeInput(value),
            ),
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }
}
