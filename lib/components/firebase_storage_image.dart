import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseStorageImage extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final String path;

  FirebaseStorageImage({
    this.width,
    this.height,
    this.borderRadius,
    @required this.path,
  });

  @override
  _FirebaseStorageImageState createState() => _FirebaseStorageImageState();
}

class _FirebaseStorageImageState extends State<FirebaseStorageImage> {
  Future<Widget> _buildImage() async {
    final src =
        await FirebaseStorage.instance.ref(this.widget.path).getDownloadURL();

    return Image.network(
      src,
      fit: BoxFit.contain,
      width: this.widget.width,
      height: this.widget.height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(this.widget.borderRadius),
      child: FutureBuilder(
        future: _buildImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data;
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
