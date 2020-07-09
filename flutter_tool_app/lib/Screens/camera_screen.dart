import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;
  CameraScreen({this.camera});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  CameraController cameraController;
  Future<void> _cameraInitializer;
  String path;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    cameraController = CameraController(
        widget.camera,
        ResolutionPreset.low,
    );

    _cameraInitializer = cameraController.initialize();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _cameraInitializer;

            // Construct the path where the image should be saved using the path
            // package.
            path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );
            print(path);
            // Attempt to take a picture and log where it's been saved.
            await cameraController.takePicture(path);
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      )
      ,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              height: 200.0,
              width: 150.0,
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 5.0,color: Colors.black)]
              ),
              child: FutureBuilder(
                future: _cameraInitializer,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the Future is complete, display the preview.
                    return CameraPreview(cameraController);
                  } else {
                    // Otherwise, display a loading indicator.
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            path!=null?Image.file(File(path)):Container(),
          ],
        ),
      ),
    );
  }
}
