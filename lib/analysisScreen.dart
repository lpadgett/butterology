//Last Modified: July 2019
//Author: Luke Padgett
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart'; //Shares picture to social media
import 'dart:async';
import 'dart:io';
import 'strings.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  Future<String> _butterState;

  DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(Strings.analysis.toUpperCase()), centerTitle: true, backgroundColor: Color.fromRGBO(255, 76, 141, 0.9)),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment(0.0, 0.0),
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
            ),
            Align(
              alignment: Alignment(0.0, 0.0),

            )
          ]
      ),
    );
  }
}