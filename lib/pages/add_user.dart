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
String rep;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<String> addUser (String email, String number, String password, String name) async {
    try
    {
      final response=await http.get(Url.domainUrl+"registration"+"&email="+email+"&phone="+number+"&password="+password+"&name="+name);
      print(Url.domainUrl+"registration"+"&email="+email+"&phone="+number+"&password="+password+"&name="+name);
      print('Response body:${response.body}');

      if (response.body=="success")
      {
        print('sucess es');
        return 'success';
      }
      else if(response.body=="already present")
      {
        print("error login");
        return 'error';
      }
      else if(response.body == "Failed"){
        print("failed");
        return 'error';
      }
    }
    catch(e)
    {
      print("Exception on addUser $e");
      return 'error';
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

      body: Builder(
        builder: (context) => Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: TextFormField(
                  controller: _nameController,
                  decoration: new InputDecoration(
                    prefixIcon: Icon(Icons.account_box),
                    labelText: "Enter Name",
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
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: TextFormField(
                  controller: _emailController,
                  decoration: new InputDecoration(
                    prefixIcon: Icon(Icons.contact_mail),
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
                  keyboardType: TextInputType.phone,
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
                      return "Phone number cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: TextFormField(
                  obscureText: true,
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
                      return "password cannot be empty";
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
                    onTap: () async {
                      if(_formKey.currentState.validate()){
                       rep = await addUser(_emailController.text, _phoneController.text, _passwordController.text, _nameController.text);
                        print('yes');
                        if(rep=='success') {
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('User added successfully')));
                          setState(() {
                            _passwordController.text = "";
                            _phoneController.text ="";
                            _emailController.text="";
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
