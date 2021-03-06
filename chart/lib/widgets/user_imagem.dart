

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagem extends StatefulWidget {
  final Function(File pickerImage) onImagePicker;

  UserImagem(this.onImagePicker);

  @override
  _UserImagemState createState() => _UserImagemState();
}

class _UserImagemState extends State<UserImagem> {
   File _pickerImageFile;


  Future<void> _picker() async{
   

    final picker = ImagePicker();
    final pickerImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150, 
    );
    setState(() {
      _pickerImageFile = File(pickerImage.path);
    });
    widget.onImagePicker(_pickerImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CircleAvatar(
            radius: 40.0,
            backgroundColor: Colors.green,
            backgroundImage: _pickerImageFile == null ? null: FileImage(_pickerImageFile),
          ),
          FlatButton.icon(
              icon: Icon(Icons.image_sharp,
                color: Theme.of(context).primaryColor,
            ),
              label: Text('Adicionar imagem',
                style: TextStyle(color: Theme.of(context).primaryColor),
             ),
              onPressed:  _picker,
          ),
        ],
      ),
      
    );
  }
}