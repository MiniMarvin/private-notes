import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:private_notes/components/base_login_screen.dart';
import 'package:private_notes/screens/camera/take_picture_screen.dart';
import 'package:private_notes/screens/confirmar_conta.dart';
import 'package:private_notes/utils/dialog.dart';
import 'package:private_notes/utils/firebaseError.dart';
import 'dart:io';

import 'package:private_notes/utils/screenUtils.dart';
import 'package:private_notes/utils/validators.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();
  String imagePath = "";
  String imageError;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  _abrirCamera() async {
    // Ensure that plugin services are initialized so that `availableCameras()`
    // can be called before `runApp()`
    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();
    final frontalCamera = cameras.where((camera) {
      return camera.lensDirection == CameraLensDirection.front;
    }).first;

    String imagePath = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TakePictureScreen(camera: frontalCamera),
      ),
    );

    debugPrint(imagePath);
    if (imagePath != null && imagePath.isNotEmpty) {
      setState(() {
        this.imagePath = imagePath;
      });
    }
  }

  _cadastrar() {
    String error = _validatePhoto();
    this.setState(() {
      this.imageError = error;
    });

    bool formularioValido = _formKey.currentState.validate();

    debugPrint(error);
    debugPrint(formularioValido.toString());

    if (formularioValido && (error == null || error.isEmpty)) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      debugPrint('validado');
      this.setState(() {
        this.loading = true;
      });
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: this.emailController.value.text,
              password: this.passwordController.value.text)
          .then((value) {
        debugPrint(value.toString());
        return FirebaseAuth.instance.signInWithEmailAndPassword(
          email: this.emailController.value.text,
          password: this.passwordController.value.text,
        );
      }).then((signInStatus) {
        debugPrint(signInStatus.toString());
        return FirebaseAuth.instance.currentUser.sendEmailVerification();
      }).then((status) {
        debugPrint('enviada a validação de email');
        final uid = FirebaseAuth.instance.currentUser.uid;

        return FirebaseStorage.instance.ref(uid).putFile(File(this.imagePath));
      }).then((imageStatus) {
        debugPrint(imageStatus.toString());
        this.setState(() {
          this.loading = false;
        });

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ConfirmarConta(),
          ),
          (route) => false,
        );
      }).catchError((Object error) {
        final errorData = handleFirebaseError(error);
        showAlertDialog(
          errorData['title'],
          errorData['content'],
          () {
            Navigator.of(context).pop();
          },
          context,
        );
      });
    } else {
      debugPrint('invalidado');
    }
  }

  String _validatePhoto() {
    if (this.imagePath.isEmpty) {
      return "A imagem não pode estar vazia";
    } else {
      return null;
    }
  }

  Widget _buildPhotoError() {
    if (this.imageError == null || this.imageError.isEmpty) {
      return Container();
    }
    return Padding(
      child: Container(
        width: double.infinity,
        child: Text(
          this.imageError,
          style: TextStyle(
            color: Theme.of(context).errorColor,
            fontSize: 12,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 10),
    );
  }

  _buildImageSelfie() {
    if (this.imagePath == null || this.imagePath.isEmpty) {
      return Image.asset(
        'assets/images/addImage.png',
        fit: BoxFit.contain,
      );
    }

    return Image.file(
      File(this.imagePath),
      fit: BoxFit.contain,
    );
  }

  Widget _buildRegisterButton() {
    if (this.loading == false) {
      return RaisedButton(
        onPressed: _cadastrar,
        child: Text('cadastrar'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('cadastro'),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).buttonColor,
        ),
        centerTitle: false,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: ListView(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _abrirCamera();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Container(
                                  child: _buildImageSelfie(),
                                  width: minSizeOfScreen(context) * 0.3,
                                  height: minSizeOfScreen(context) * 0.3,
                                ),
                                Padding(
                                  child: Container(
                                    child: Text(
                                      'adicione uma foto ao seu perfil',
                                      textAlign: TextAlign.center,
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                            0.5 -
                                        60,
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.start,
                            ),
                            _buildPhotoError()
                          ],
                        ),
                      ),
                    ),
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
                      padding: EdgeInsets.only(top: 50, bottom: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: _buildRegisterButton(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
