import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:private_notes/components/base_login_screen.dart';
import 'package:private_notes/screens/camera/take_picture_screen.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();
  String imagePath = "";
  String imageError;

  _abrirCamera() async {
    // Ensure that plugin services are initialized so that `availableCameras()`
    // can be called before `runApp()`
    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();
    final frontalCamera = cameras.where((camera) {
      return camera.lensDirection == CameraLensDirection.front;
    }).first;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TakePictureScreen(camera: frontalCamera),
      ),
    );
  }

  _cadastrar() {
    String error = _validatePhoto();
    this.setState(() {
      this.imageError = error;
    });

    bool formularioValido = _formKey.currentState.validate();

    if (formularioValido && error != null && error.isNotEmpty) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.

      debugPrint('validado');
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
          debugPrint('tap');
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
                                Image.asset('assets/images/addImage.png'),
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
                      decoration: const InputDecoration(
                        hintText: 'seu@email.com',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'o email não pode estar vazio';
                        }
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
            ],
          ),
        ),
      ),
    );
  }
}
