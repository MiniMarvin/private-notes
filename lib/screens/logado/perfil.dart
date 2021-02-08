import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:private_notes/components/firebase_storage_image.dart';
import 'package:private_notes/screens/logado/editar_perfil.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  _nome() {
    String nome = FirebaseAuth.instance.currentUser.displayName;
    if (nome == null) {
      return 'N/A';
    }
    return nome;
  }

  _email() {
    return FirebaseAuth.instance.currentUser.email;
  }

  _uid() {
    return FirebaseAuth.instance.currentUser.uid;
  }

  _editar() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarPerfil(),
      ),
    );
    FirebaseAuth.instance.currentUser.reload();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('perfil'),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                FirebaseStorageImage(
                  path: _uid(),
                  width: MediaQuery.of(context).size.width / 2,
                  borderRadius: 10,
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'email',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                _email(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'nome',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                _nome(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: RaisedButton(
                onPressed: () => _editar(),
                child: Text('editar'),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
