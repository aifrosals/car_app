import 'dart:convert';

import 'package:car_app/config/api.dart';
import 'package:car_app/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void addUser (String email, String number, String password) async {
    try
    {

      //  var url=urldomain.domain+"login";
      final response=await http.get(Url.domainUrl+"registration"+"&email="+email+"&phone="+number+"&password="+password);
      print(Url.domainUrl+"registeration"+"&email="+email+"&phone="+number+"&password="+password);
      print('Response body:${response.body}');

      if (response.body=="success")
      {
        print('sucess es');
      }
      else if(response.body=="already present")
      {
        print("error login");
      }

    }
    catch(e)
    {
      print("Exception on addUser $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add User', style: CustomStyles.orangeTextStyle,),
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
                controller: _emailController,
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
                controller: _phoneController,
                decoration: new InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  labelText: "Enter Phone Number",
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
                controller: _passwordController,
                decoration: new InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key),
                  labelText: "Enter password",
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
                      addUser(_emailController.text, _phoneController.text, _passwordController.text);
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
