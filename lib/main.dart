//Last Modified: July 2019
//Author: Luke Padgett
import 'package:flutter/material.dart';
import 'analysisScreen.dart';
import 'strings.dart';

void main() { //Start app
  runApp(
      MaterialApp(
        title: Strings.title,
        home: HomeScreen()
      )
  );
}

//Create Home screen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.title,
      home: Scaffold(
        backgroundColor: Color.fromRGBO(255, 76, 141, 0.9), //Set background color
        appBar: AppBar(
          title: Text(Strings.home),
        ),
        body: Stack ( //Use stack to support aligning multiple children
          children: <Widget>[
            Align(
              alignment: Alignment(0.0, 0.5), //Assign alignment
              child: FlatButton(
                child: Text(Strings.analysisButton),
                color: Color.fromRGBO(252, 245, 85, 0.8), //Set button color
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AnalysisScreen())); //Navigate to analysis screen
                }
              ),
            ),
            Align(
              alignment: Alignment(0.0, 0.7), //Assign alignment
              child: FlatButton(
                child: Text(Strings.shareStreakButton),
                color: Color.fromRGBO(252, 245, 85, 0.8), //Set button color
                onPressed: () {
                  //TODO: Create sharing feature so people can share their streaks on social media/text/whatever
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AnalysisScreen()));
                }
              )
            )
          ],
        ),
      ),
    );
  }
}


