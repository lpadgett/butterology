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
            //TODO: Implement title text on home page
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AnalysisScreen())); //Navigate to analysis screen
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AnalysisScreen()));
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


