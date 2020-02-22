import 'package:car_app/config/api.dart';
import 'package:car_app/pages/car_list.dart';
import 'package:car_app/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:car_app/models/car.dart';
import 'package:http/http.dart' as http;

class ManageCar extends StatefulWidget {
  final Car car;
  ManageCar({this.car});
  @override
  _ManageCarState createState() => _ManageCarState();
}

class _ManageCarState extends State<ManageCar> {

  String rep;

  bool enabledEdit = false;
  Car tempCar = Car();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _carHolderNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _carPlateController = TextEditingController();
  TextEditingController  _carParkingLimitController = TextEditingController();


  void deleteCar () async {
    final response=await http.get(Url.domainUrl+"delete_car"+"&plate="+tempCar.plateNumber);
    print('Response body:${response.body}');
  }

  Future<String> addCar (String name, String number, String plate, String limit) async {
    try
    {
      final response=await http.get(Url.domainUrl+"edit_car"+"&name="+name+"&number="+number+"&plate="+plate+"&limit="+limit+"&preplate="+tempCar.plateNumber);
      print('Response body:${response.body}');
      if (response.body=="success")
      {
        print('sucess es');
        return 'success';
      }
      else if(response.body=="error")
      {
        print("error editing");
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
  void initState() {
    // TODO: implement initState
    super.initState();
    tempCar = widget.car;
    print(tempCar.carHolderName);
    _carHolderNameController.text = tempCar.carHolderName;
    _phoneController.text = tempCar.phoneNumber;
    _carPlateController.text = tempCar.plateNumber;
    _carParkingLimitController.text = tempCar.parkingLimit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Car', style: CustomStyles.orangeTextStyle,),
        backgroundColor: Colors.white12,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.orange),
        centerTitle: true,
      ),

      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10,),
            enabledEdit ?
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: TextFormField(
                    //initialValue: tempCar.carHolderName,
                    //enabled: false,
                    controller: _carHolderNameController,
                    decoration: new InputDecoration(
                      prefixIcon: Icon(Icons.account_box),
                      labelText: "Enter Name of Car Holder",
                      hintText: tempCar.carHolderName,
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
                      hintText: tempCar.phoneNumber,
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ), //fillColor: Colors.green
                    ),
                    validator: (val) {
                      if (val.length == 0) {
                        return "Phone cannot be empty";
                      }
                      else {
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
                    controller: _carPlateController,
                    decoration: new InputDecoration(
                      prefixIcon: Icon(Icons.featured_play_list),
                      labelText: "Enter Plate Number",
                      hintText: tempCar.plateNumber,
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
                      hintText: tempCar.parkingLimit,
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
                      }
                      else if(int.parse(val) > 10){
                        return 'Parking Limit cannot exceed 10 hrs';
                      }
                      else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                ),


              ],
            ) : NonEditAble(car: tempCar,),
            SizedBox(height: 10,),
            enabledEdit ?
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Material(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () async{
                          if(_formKey.currentState.validate()){
                          rep =  await  addCar(_carHolderNameController.text, _phoneController.text, _carPlateController.text,_carParkingLimitController.text);
                          if(rep == 'success'){
                            setState(() {
                              tempCar.carHolderName = _carHolderNameController.text;
                              tempCar.plateNumber = _carPlateController.text;
                              tempCar.phoneNumber = _phoneController.text;
                              tempCar.parkingLimit = _carParkingLimitController.text;
                              print("name "+tempCar.carHolderName);
                              enabledEdit = false;
                            },
                            );
                          }

                          }
                        },
                        splashColor: Colors.purple,
                        highlightColor: Colors.orange,
                        child: Container(
                          height: 50,
                          width:  70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Material(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                        setState(() {
                          enabledEdit = false;
                        });
                        },
                        splashColor: Colors.purple,
                        highlightColor: Colors.orange,
                        child: Container(
                          height: 50,
                          width:  70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: Text(
                              "Cancel",
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
            ) : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                   setState(() {
                     enabledEdit = true;
                   });
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
                        "Edit",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    deleteCar();
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => CarList())
                    );
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
                        "Delete",
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
    );
  }
}
class NonEditAble extends StatelessWidget {
  final Car car;
  NonEditAble({this.car});
  @override
  Widget build(BuildContext context) {
    return             Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: TextFormField(
            initialValue: car.carHolderName,
            enabled: false,
            decoration: new InputDecoration(
              prefixIcon: Icon(Icons.account_box),
              labelText: "Enter Name of Car Holder",
              hintText: "Car Name",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
              //fillColor: Colors.green
            ),
            validator: (val) {
              if (val.length == 0) {
                return "Email cannot be empty";
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
            enabled: false,
            initialValue: car.phoneNumber,
          //  controller: _phoneController,
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
                return "Email cannot be empty";
              }
              else {
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
            initialValue: car.plateNumber,
            enabled: false,
           // controller: _carPlateController,
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
                return "Plate Number cannot be empty";
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
            initialValue: car.parkingLimit,
            enabled: false,
            //controller: _carParkingLimitController,
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
      ],
    );
  }
}