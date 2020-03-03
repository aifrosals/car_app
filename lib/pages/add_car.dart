import 'package:camera/camera.dart';
import 'package:car_app/config/api.dart';
import 'package:car_app/pages/take_picture_page.dart';
import 'package:car_app/theme/styles.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';


class AddCar extends StatefulWidget {
  @override
  _AddCarState createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  String _path;
  String _line = '';

String rep;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _carHolderNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _carPlateController = TextEditingController();
  TextEditingController _carParkingLimitController = TextEditingController();


  void _showPhotoLibrary() async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
    print('working');
    setState(() {
      _path = file.path;
    });
    setState(() {
      readText();
    });
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
    _line = "";
    FirebaseVisionImage selectedImage = FirebaseVisionImage.fromFilePath(_path);
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText visionText = await textRecognizer.processImage(selectedImage);

    for(TextBlock block in visionText.blocks) {
     // print(block.text);
      for(TextLine line in block.lines) {
        //print(line.text);
        setState(() {
          print(line.text);
          _line = _line + line.text;
        });
      }
    }
    setState(() {
      _carPlateController.text = _line;
    });
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

  Future<String> addCar (String name, String number, String plate, String parkingLimit) async {
    try
    {
      final response=await http.get(Url.domainUrl+"add_info"+"&name="+name+"&number="+number+"&plate="+plate+"&parking_limit="+parkingLimit);
      print(Url.domainUrl+"add_info"+"&name="+name+"&number="+number+"&plate="+plate+"&parking_limit="+parkingLimit);
      print('Response body:${response.body}');
      if (response.body=="success")
      {
        print('sucess es');
        return 'success';
      }
      else if(response.body=="error")
      {
        print("error login");
        return 'error';
      }
      return 'error';

    }
    catch(e)
    {
      print("Exception on addCar $e");
      return 'error';

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Car', style: CustomStyles.orangeTextStyle,),
        backgroundColor: Colors.white12,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.orange),
        centerTitle: true,
      ),

      body: Builder(
        builder: (context) => Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: TextFormField(
                  controller: _carHolderNameController,
                  decoration: new InputDecoration(
                    prefixIcon: Icon(Icons.account_box),
                    labelText: "Enter Name of Car Holder",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "Name cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: TextFormField(
                  controller: _phoneController,
                  decoration: new InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: "Enter Phone",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ), //fillColor: Colors.green
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "phone number cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.phone,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: TextFormField(
                  controller: _carPlateController,
                  decoration: new InputDecoration(
                    prefixIcon: Icon(Icons.featured_play_list),
                    labelText: "Enter Plate Number",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "Plate number cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: TextFormField(
                  controller: _carParkingLimitController,
                  decoration: new InputDecoration(
                    prefixIcon: Icon(Icons.access_time),
                    labelText: "Enter Parking limit",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "Parking Limit cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
            SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  _showOptions(context);
                },
                  child: Center(child: Text('Take Photo for Plate Number', style: TextStyle(fontSize: 16),))),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async{
                      if(_formKey.currentState.validate()){
                         rep = await addCar(_carHolderNameController.text, _phoneController.text, _carPlateController.text, _carParkingLimitController.text);
                         if(rep=='success') {
                           Scaffold.of(context).showSnackBar(SnackBar(content: Text('Car added successfully')));
                           setState(() {
                             _carHolderNameController.text = "";
                             _carPlateController.text ="";
                             _carParkingLimitController.text="";
                             _phoneController.text="";
                           });
                         }
                         else if(rep=='error') {
                         }
                      }
                    },
                    splashColor: Colors.purple,
                    highlightColor: Colors.orange,
                    child: Container(
                      height: 50,
                      width:  200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
