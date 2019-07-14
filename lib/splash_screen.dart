import 'package:flutter/material.dart';

//Widget with mutable state. Constitutes splash screen widget.
//Hosts current configuration of state
class SplashScreen extends StatefulWidget {

  //Builds stateful widget. Note that the fat arrow (=>) is a shortcut
  //for having brackets and a return statement.
  @override
  State<StatefulWidget> createState() => new SplashScreenState();

}

//Logic and internal state for splash screen
//Current configuration of this is hosted in SplashScreen class above
class SplashScreenState extends State<SplashScreen> {

  //Calls initState()
  @override
  void initState() {
    super.initState();
  }


  //Concrete implementation of State.build
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration( //Draws a box decoration
        color: const Color(0xff6320), //Chooses color
        image: DecorationImage(
            image: AssetImage('assets/images/butter_SplashScreen.png'), //Image for splash screen
            fit: BoxFit.contain //Contains butter picture on splash screen in as large of a box as possible without stretching it oddly
        ),
      ),
      child: Align(
        alignment: Alignment(0.0, 0.5), //Puts CircularProgressIndicator in middle of bottom half of screen
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFCFCFC)), //Whitish-grey color for CircularProgressIndicator
        )
      )
    );
  }
}
