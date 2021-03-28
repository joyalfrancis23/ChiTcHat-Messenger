import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickersection extends StatefulWidget {
  ImagePickersection(this.imageFn);
  final void Function(File picked) imageFn;
  @override
  _ImagePickersectionState createState() => _ImagePickersectionState();
}

class _ImagePickersectionState extends State<ImagePickersection> {
  
  File _pickedImage;
  final picker=ImagePicker();
  void _pickImage() async {
    
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    
    setState(() {
      if (pickedFile != null) {
        _pickedImage = File(pickedFile.path);
        widget.imageFn(_pickedImage);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.blue[900],
          backgroundImage: _pickedImage!=null?FileImage(_pickedImage):null,
        ),

        Container(
          child:TextButton.icon(onPressed:_pickImage, 
          icon: Icon(Icons.image,color: Colors.blue,),
          label: Text('Add an image',style: TextStyle(color: Colors.blue,),),
          )
        ),


      ],
    );
  }
}