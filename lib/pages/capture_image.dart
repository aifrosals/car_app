import 'dart:io';
import 'package:camera/camera.dart';
import 'package:car_app/pages/take_picture_page.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CaptureImage extends StatefulWidget {

//  // Obtain a list of the available cameras on the device.
//  final cameras = await availableCameras();
//
//  // Get a specific camera from the list of available cameras.
//  final firstCamera = cameras.first;
  @override
  _CaptureImageState createState() => _CaptureImageState();
}

class _CaptureImageState extends State<CaptureImage> {
   String _path;
   String _line = '';
  void _showPhotoLibrary() async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _path = file.path;
    });
    readText();
  }

  void _showCamera() async {

    final cameras = await availableCameras();
    final camera = cameras.first;

    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePicturePage(camera: camera)));

    setState(() {
      _path = result;
    });
     readText();
  }

  Future readText() async {
   FirebaseVisionImage selectedImage = FirebaseVisionImage.fromFilePath(_path);
   TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
   VisionText visionText = await textRecognizer.processImage(selectedImage);

   for(TextBlock block in visionText.blocks) {
     for(TextLine line in block.lines) {
       print(line.text);
       setState(() {
       _line = line.text;
       });
     }
   }
  }

  void _showOptions(BuildContext context) {

    showModalBottomSheet (
        context: context,
        builder: (context) {
          return Container (
              height: 150,
              child: Column(children: <Widget> [
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _showCamera();
                    },
                    leading: Icon(Icons.photo_camera),
                    title: Text("Take a picture from camera")
                ),
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _showPhotoLibrary();
                    },
                    leading: Icon(Icons.photo_library),
                    title: Text("Choose from photo library")
                )
              ])
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold (
        body: SafeArea(
          child: Column(children: <Widget> [
            _path == null ?
            //Image.asset("images/place-holder.png")
            Container()
                :
            Image.file(File(_path)),
            Text(_line),
            FlatButton(
              child: Text("Take Picture", style: TextStyle(color: Colors.white)),
              color: Colors.green,
              onPressed: () {
                _showOptions(context);
              },
            )
          ]),
        )
    );
  }
}