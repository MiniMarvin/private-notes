import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:private_notes/components/base_login_screen.dart';
import 'package:private_notes/components/buttons/custom_text_button.dart';

class ConfirmarConta extends StatefulWidget {
  @override
  _ConfirmarContaState createState() => _ConfirmarContaState();
}

class _ConfirmarContaState extends State<ConfirmarConta> {
  bool loading = false;
  Timer _timer;

  @override
  void initState() {
    super.initState();

    Future(() async {
      _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
        await FirebaseAuth.instance.currentUser.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user.emailVerified) {
          timer.cancel();
          debugPrint('email verificado!');
          _ignoreRegistration();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  _resendEmail() {
    setState(() {
      this.loading = true;
    });
    FirebaseAuth.instance.currentUser.sendEmailVerification().then(
          (value) => setState(() {
            this.loading = false;
          }),
        );
  }

  _ignoreRegistration() {
    // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
  }

  Widget _buildRegisterButton() {
    if (this.loading == false) {
      return RaisedButton(
        onPressed: _resendEmail,
        child: Text('reenviar email'),
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
    return BaseLoginScreen(
      title: 'confirme seu email',
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 40),
            child: Text(
              'foi enviado um email de confirmação à sua conta, verifique sua caixa de email e spam, caso não tenha recebido o email utilize o botão abaixo:',
            ),
          ),
          _buildRegisterButton(),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: CustomTextButton(
              action: _ignoreRegistration,
              actionText: 'pular verificação',
              leftText: 'ou ',
            ),
          ),
        ],
      ),
    );
  }
}
