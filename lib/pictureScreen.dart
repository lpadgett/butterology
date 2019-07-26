//Last Modified: July 2019
//Author: Luke Padgett
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart'; //Shares picture to social media
import 'dart:async'; //For awaiting Cameras
import 'package:camera/camera.dart'; //For cameras
import 'dart:io'; //For file I/O
import 'strings.dart';
import 'analysisScreen.dart';


//Allows users to take picture using a camera that is
//Passed in via the cameraSelection method in main.dart.
class PictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const PictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  PictureScreenState createState() => PictureScreenState();

}

class PictureScreenState extends State<PictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    /*
     * Create CameraController to display current output from camera
     * Note: widget.camera gets the camera that is currently available.
     * The currently available camera was passed in through the
     * cameraSelection method in main.dart.
     */
    _controller = CameraController(widget.camera, ResolutionPreset.high);

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Strings.analysisButton.toUpperCase()), centerTitle: true, backgroundColor: Color.fromRGBO(255, 76, 141, 0.9)),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            //display a CircularProgressIndicator until future is complete
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        backgroundColor: Color.fromRGBO(252, 245, 85, 0.8),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Construct the path where the image should be saved using the
            // pattern package.
            final path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png', //TODO: remove this hardcoded .png extension
            );

            // Attempt to take a picture and log where it's been saved.
            await _controller.takePicture(path);

            // If the picture was taken, display it on a new screen.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}