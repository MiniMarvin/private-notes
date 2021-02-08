import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:private_notes/components/firebase_storage_image.dart';
import 'package:private_notes/screens/camera/take_picture_screen.dart';
import 'package:private_notes/utils/screenUtils.dart';
import 'package:private_notes/utils/validators.dart';

class EditarPerfil extends StatefulWidget {
  @override
  _EditarPerfilState createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  final _formKey = GlobalKey<FormState>();
  String imagePath = "";
  final emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    nameController..text = FirebaseAuth.instance.currentUser.displayName;
  }

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

  _salvar() async {
    setState(() {
      this.loading = true;
    });
    String nome = this.nameController.value.text;
    if (nome != null && nome.isNotEmpty) {
      await FirebaseAuth.instance.currentUser.updateProfile(displayName: nome);
    }

    await FirebaseStorage.instance
        .ref(FirebaseAuth.instance.currentUser.uid)
        .putFile(File(this.imagePath));

    setState(() {
      this.loading = false;
    });

    Navigator.pop(context);
  }

  _buildImageSelfie() {
    if (this.imagePath == null || this.imagePath.isEmpty) {
      return FirebaseStorageImage(
        path: FirebaseAuth.instance.currentUser.uid,
        width: 200,
        height: 200,
        borderRadius: 10,
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
        onPressed: () => _salvar(),
        child: Text('atualizar'),
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
        title: Text('EditarPerfil'),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
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
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 5),
                    child: Row(
                      children: [
                        Text(
                          'nome',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'seu nome',
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
    );
  }
}
