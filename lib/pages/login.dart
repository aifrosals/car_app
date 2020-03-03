import 'dart:convert';
import 'package:car_app/config/api.dart';
import 'package:car_app/pages/find_car.dart';
import 'package:car_app/pages/menu.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {

  final String loginAS;

  Login({this.loginAS});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  void checkinfo(String email, String password) async {
    try
    {

    //  var url=urldomain.domain+"login";
      final response=await http.get(Url.domainUrl+"login"+"&email="+email+"&password="+password);
      print('Response body:${response.body}');
      var jsonResponse=json.decode(response.body);
      // print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj"+_fullname.text);
//print(url+"&f_name+="+_fullname.text+"&phone+="+_number.text+"&email+="+_email.text+"&password+="+_password.text);

      var requestresponse=jsonResponse['response'];
      // var name=jsonResponse['name'];

      if (requestresponse=="success")
      {
        var type = jsonResponse['Type'];
        print(type);
        savePreference(type);
        if(type == 'admin'){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Menu()),
          );
        }
        else if(type == 'user') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => FindCar()),
          );
        }

      }
      else if(requestresponse=="error")
      {
        print("error login");
      }
    }
    catch(e)
    {
      print("Exception on way $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;




    return Scaffold(
      body: Container(
        color: Colors.purple,
        height: height,
        width: width,
        child: ListView(
          children: <Widget>[
            Container(
              height: height * 0.23,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text('Login as ${widget.loginAS}', style: TextStyle(color: Colors.white),),
              ),
            ),
            Container(
              height: height * 0.43,
              child: Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: height * 0.05,
                          ),
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
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20),
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: new InputDecoration(
                                prefixIcon: Icon(Icons.vpn_key),
                                labelText: "Enter Password",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(),
                                ),
                                //fillColor: Colors.green
                              ),
                              validator: (val) {
                                if (val.length == 0) {
                                  return "Password cannot be empty";
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
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Material(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
    if(_formKey.currentState.validate()) {
      checkinfo(_emailController.text, _passwordController.text);
    }
                              },
                              splashColor: Colors.purple,
                              highlightColor: Colors.orange,
                              child: Container(
                                height: height * 0.08,
                                width: width * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: height * 0.025,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void savePreference(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('type', type);
  }
}
