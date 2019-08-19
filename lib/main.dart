//Last Modified: August 2019
//Author: Luke Padgett
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'pictureScreen.dart';
import 'package:share/share.dart'; //Shares picture to social media
//imports for strings and asset paths
import 'strings.dart';
import 'assets.dart';
import 'colors.dart';

void main() { //Start app
  runApp(
      MaterialApp(
        title: Strings.title,
        home: HomeScreen()
      )
  );
}

//Async method for selecting camera to pass to PictureScreen
//Input parameter of BuildContext so it can use Navigator.push
Future<void> cameraSelection(BuildContext context) async {
  //Obtain list of the available cameras on the device
  final cameras = await availableCameras();

  //Get the first available camera and store it
  final firstCamera = cameras.first;

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PictureScreen(
        camera: firstCamera,
      )
    )
  );

}

//Create Home screen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]); //Prevent home screen from rotating sideways

    double buttonWidth = screenWidth(context, divisionFactor: 1.5);
    double buttonHeight = screenHeight(context, divisionFactor: 10);

    return MaterialApp(
      title: Strings.title,
      home: Scaffold(
        backgroundColor: ColorPalette.pinkRedBackgroundColor, //Set background color
        body: Stack ( //Use stack to support aligning multiple children
          children: <Widget>[
            Align(
              alignment: Alignment(0.0, -0.8),
                child: Text( //Homescreen text
                 Strings.title.toUpperCase(),
                  style: new TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                   fontWeight: FontWeight.bold
                  ),
                ),
            ),
            Align(
              alignment: Alignment(0.0, -0.3), //assign alignment
              child: Container(
                width: screenWidth(context, divisionFactor: 1),
                height: screenHeight(context, divisionFactor: 2),
                child: Image.asset (
                  Assets.homeScreenButter, //image to be displayed on homescreen
                ),
              ),
            ),
            Align( //ANALYZE BUTTER BUTTON
              alignment: Alignment(0.0, 0.4), //Assign alignment
              child: MaterialButton(
                height: buttonHeight,
                minWidth: buttonWidth,
                color: ColorPalette.yellowButtonColor, //Set button color
                child: Text(
                    Strings.analysisButton.toUpperCase(),
                    style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                  ),
                ),
                onPressed: () {
                  cameraSelection(context);
                },
                splashColor: Colors.yellowAccent,
              ),
            ),
            Align( //SHARE STREAK BUTTON
              alignment: Alignment(0.0, 0.75), //Assign alignment
              child: MaterialButton(
                height: buttonHeight,
                minWidth: buttonWidth,
                color: ColorPalette.yellowButtonColor, //Set button color
                child: Text(
                    Strings.shareUs.toUpperCase(),
                    style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.white
                  ),
                ),
                onPressed: () {
                  Share.share(Strings.shareUsText + Strings.shareLink);
                },
                splashColor: Colors.yellowAccent,
              )
            )
          ],
        ),
      ),
    );
  }

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
  static double screenHeight(BuildContext context, {double divisionFactor = 1}) {
    return screenSize(context).height / divisionFactor;
  }

  static double screenWidth(BuildContext context, {double divisionFactor = 1}) {
    return screenSize(context).width / divisionFactor;
  }
}