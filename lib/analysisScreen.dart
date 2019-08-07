//Last Modified: August 2019
//Author: Luke Padgett
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share/share.dart'; //Shares picture to social media
import 'dart:async';
import 'dart:io';
import 'strings.dart';
import 'colors.dart';

class AnalysisScreen extends StatelessWidget {
  final String imagePath;

  AnalysisScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Boolean stores status of butter
    bool _isButter = isButter();
    var screenSize = MediaQuery.of(context).size;

    if(!_isButter) {
      return Scaffold(
        appBar: AppBar(title: Text(Strings.analysis.toUpperCase()),
            centerTitle: true,
            backgroundColor: ColorPalette.pinkRedBackgroundColor,
            elevation: 0
        ),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment(0.0, 0.0),
                child: Image.file(
                  File(imagePath),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              Align(
                alignment: Alignment(0.0, -1.5),
                child: Container(
                  decoration: new BoxDecoration(
                    color: ColorPalette.pinkRedBackgroundColor,
                    borderRadius: new BorderRadius.all(Radius.elliptical(screenWidth(context), screenHeight(context, divisionFactor: 5))),
                  ),
                  height: screenHeight(context, divisionFactor: 3),
                  width: screenWidth(context),
                ),
              ),
              Align(
                alignment: Alignment(0.0, -0.9),
                child: Text( //Homescreen text
                  Strings.notButter.toUpperCase(),
                  style: new TextStyle(
                      fontSize: 35.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              )
            ]
        ),
      );
    } else {

    }
  }
}

bool isButter() {
  return false;
}

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}
double screenHeight(BuildContext context, {double divisionFactor = 1}) {
  return screenSize(context).height / divisionFactor;
}
double screenWidth(BuildContext context, {double divisionFactor = 1}) {
  return screenSize(context).width / divisionFactor;
}