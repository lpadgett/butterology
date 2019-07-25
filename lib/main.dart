//Last Modified: July 2019
//Author: Luke Padgett
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'pictureScreen.dart';

//imports for strings and asset paths
import 'strings.dart';
import 'assets.dart';

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
    return MaterialApp(
      title: Strings.title,
      home: Scaffold(
        backgroundColor: Color.fromRGBO(255, 76, 141, 0.9), //Set background color
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
              alignment: Alignment(0.2, -0.3), //assign alignment
              child: FractionallySizedBox(
                widthFactor: 0.8,
                heightFactor: 0.4,
                child: Image.asset (
                  Assets.homeScreenButter, //image to be displayed on homescreen
                ),
              ),
            ),
            Align( //ANALYZE BUTTER BUTTON
              alignment: Alignment(0.0, 0.45), //Assign alignment
              child: MaterialButton(
                height: 45.0,
                minWidth: 200.0,
                color: Color.fromRGBO(252, 245, 85, 0.8), //Set button color
                child: Text(
                    Strings.analysisButton,
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
                height: 45.0,
                minWidth: 200.0,
                color: Color.fromRGBO(252, 245, 85, 0.8), //Set button color
                child: Text(
                    Strings.shareStreakButton,
                    style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.white
                  ),
                ),
                onPressed: () {
                  //TODO: Create sharing feature so people can share their streaks on social media/text/whatever
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PictureScreen()));
                },
                splashColor: Colors.yellowAccent,
              )
            )
          ],
        ),
      ),
    );
  }
}


