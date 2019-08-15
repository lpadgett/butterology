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
import 'package:tflite/tflite.dart';

class AnalysisScreen extends StatelessWidget {
  final String imagePath;

  AnalysisScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery
        .of(context)
        .size;

    return analysisScreen(context, imagePath, butterStatus());
  }
}

String butterStatus(){ //TODO: implement tensorflow lite analysis method of determining whether or not butter has crumbs
  if (notButter) { //notButter is placeholder for return value from tflite model
    return Strings.notButter;
  } else if (noCrumbs) { //noCrumbs is placeholder for return value from tflite model
    return Strings.noCrumbs;
  } else {
    return Strings.crumbs;
  }
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

Scaffold analysisScreen(BuildContext context, String imagePath, String butterStatus){
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
              child: Container(
                width: screenWidth(context, divisionFactor: 1),
                height: screenHeight(context, divisionFactor: 1),
                child: Image.file(
                  File(imagePath),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              )
          ),
          Align(
            alignment: Alignment(0.0, -2.00),
            child: Container(
              decoration: new BoxDecoration(
                color: ColorPalette.pinkRedBackgroundColor,
                borderRadius: new BorderRadius.all(Radius.elliptical(screenWidth(context), screenHeight(context, divisionFactor: 10))),
              ),
              height: screenHeight(context, divisionFactor: 3),
              width: screenWidth(context),
            ),
          ),
          Align(
            alignment: Alignment(0.0, -1.00),
            child: Text( //Homescreen text
              butterStatus.toUpperCase(),
              style: new TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          )
        ]
    ),
  );
}