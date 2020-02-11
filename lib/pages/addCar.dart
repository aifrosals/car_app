import 'package:car_app/theme/styles.dart';
import 'package:flutter/material.dart';

class AddCar extends StatefulWidget {
  @override
  _AddCarState createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Car', style: CustomStyles.orangeTextStyle,),
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
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: TextFormField(
                decoration: new InputDecoration(
                  prefixIcon: Icon(Icons.account_box),
                  labelText: "Enter Email",
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
                decoration: new InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  labelText: "Enter Email",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ), //fillColor: Colors.green
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
                decoration: new InputDecoration(
                  prefixIcon: Icon(Icons.featured_play_list),
                  labelText: "Enter Email",
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
              padding: const EdgeInsets.all(20.0),
              child: Material(
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    if(_formKey.currentState.validate()){
                      print('yes');
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

    );
  }
}
