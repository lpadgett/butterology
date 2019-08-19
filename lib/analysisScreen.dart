//Last Modified: August 2019
//Author: Luke Padgett
import 'dart:collection';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share/share.dart';
import 'dart:async';
import 'dart:io';
import 'strings.dart';
import 'colors.dart';
import 'assets.dart';
import 'package:tflite/tflite.dart';

class AnalysisScreenClass extends StatefulWidget {
  @override
  AnalysisScreen createState() => AnalysisScreen();
  final String imagePath;
  AnalysisScreenClass({Key key, this.imagePath}) : super(key: key);
}

class AnalysisScreen extends State<AnalysisScreenClass> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery
        .of(context)
        .size;

    double buttonWidth = screenWidth(context, divisionFactor: 1.5);
    double buttonHeight = screenHeight(context, divisionFactor: 10);
    String butterStatusString = butterStatus(widget.imagePath);

    return analysisScreen(
        context, widget.imagePath, butterStatusString, buttonWidth, buttonHeight);
  }

  LinkedHashMap butterStatusMap; //For use in butterStatus

  String butterStatus(String imagePath) {
    if(butterStatusMap == null) {
      analyzeButter(imagePath).then((val) =>
          setState(() {
            butterStatusMap = val[0];
          }));
    }

    if (butterStatusMap != null) {
      String result = butterStatusMap['label'];
      if (result ==
          'notbutter') { //TODO: Find a way to not hard-code these later
        return Strings.notButter;
      } else if (result == 'hascrumbs') {
        return Strings.crumbs;
      } else if (result == 'nocrumbs') {
        return Strings.noCrumbs;
      }
    }
    return '';
  }

  Future<List> analyzeButter(String imagePath) async {
    String model = await Tflite.loadModel(
        model: Assets.butterModel,
        labels: Assets.butterModelLabels,
        numThreads: 1 // defaults to 1
    );
    var butterPicture = await Tflite.runModelOnImage(
        path: imagePath,
        // required
        imageMean: 0.0,
        // defaults to 117.0
        imageStd: 255.0,
        // defaults to 1.0
        numResults: 1,
        // defaults to 5
        threshold: 0.2,
        // defaults to 0.1
        asynch: true // defaults to true
    );
    return butterPicture;
  }

  static Size screenSize(BuildContext context) {
    return MediaQuery
        .of(context)
        .size;
  }

  static double screenHeight(BuildContext context, {double divisionFactor = 1}) {
    return screenSize(context).height / divisionFactor;
  }

  static double screenWidth(BuildContext context, {double divisionFactor = 1}) {
    return screenSize(context).width / divisionFactor;
  }

  Scaffold analysisScreen(BuildContext context, String imagePath,
      String butterStatus, double buttonWidth, double buttonHeight) {
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
                  borderRadius: new BorderRadius.all(Radius.elliptical(
                      screenWidth(context),
                      screenHeight(context, divisionFactor: 10))),
                ),
                height: screenHeight(context, divisionFactor: 3),
                width: screenWidth(context),
              ),
            ),
            Align(
              alignment: Alignment(0.0, -1.00),
              child: Text( //Displays butter status
                butterStatus.toUpperCase(),
                style: new TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.0, 0.75),
              child: MaterialButton(
                height: buttonHeight,
                minWidth: buttonWidth,
                color: ColorPalette.yellowButtonColor, //Set button color
                child: Text(
                  Strings.share.toUpperCase(),
                  style: new TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
                onPressed: () {
                  switch (butterStatus) {
                    case Strings.notButter: {
                      Share.share(Strings.notButterLink);
                    }
                    break;
                    
                    case Strings.crumbs: {
                      Share.share(Strings.crumbsLink);
                    }
                    break;
                    
                    case Strings.noCrumbs: {
                      Share.share(Strings.noCrumbsLink);
                    }
                    break;
                  }
                },
              ),
            )
          ]
      ),
    );
  }
}