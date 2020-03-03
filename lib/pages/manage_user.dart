import 'package:car_app/config/api.dart';
import 'package:car_app/models/user.dart';
import 'package:car_app/pages/user_list.dart';
import 'package:car_app/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ManageUser extends StatefulWidget {
  final User user;
  ManageUser({this.user});
  @override
  _ManageUserState createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  String rep;
  bool enabledEdit = false;
  User tempUser = User();

  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void deleteUser () async {
    try{
    final response=await http.get(Url.domainUrl+"delete_user"+"&email="+tempUser.email);
    print('Response body:${response.body}');}
    catch (e) {
      print('delet user $e');
    }
  }

  Future<String> editUser (String email, String number, String password, String name) async {
    try
    {
      final response=await http.get(Url.domainUrl+"edit_user"+"&email="+email+"&number="+number+"&password="+password+"&preemail="+tempUser.email+"&name="+name);
      print('Response body:${response.body}');
      if (response.body=="success")
      {
        print('sucess es');
        return 'success';
      }

      else if(response.body=="error")
      {
        print("error editing user");
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
    tempUser = widget.user;
    _nameController.text = tempUser.name;
    _emailController.text = tempUser.email;
    _phoneController.text = tempUser.phone;
    _passwordController.text = tempUser.password;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage User', style: CustomStyles.orangeTextStyle,),
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
                      hintText: tempUser.email,
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
                      hintText: tempUser.phone,
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
                    controller: _passwordController,
                    decoration: new InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key),
                      hintText: tempUser.password,
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
                SizedBox(height: 10,),
              ],
            ) : NonEditAble(user: tempUser,),
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
                           rep = await editUser(_emailController.text, _phoneController.text, _passwordController.text,_nameController.text);
                            if(rep=='success')
                              {
                                setState(() {
                                  tempUser.email = _emailController.text;
                                  tempUser.phone = _phoneController.text;
                                  tempUser.password = _passwordController.text;
                                  tempUser.name = _nameController.text;
                                  print("name "+tempUser.email);
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
                    deleteUser();
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => UserList())
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
  final User user;
  NonEditAble({this.user});
  @override
  Widget build(BuildContext context) {
    return             Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: TextFormField(
            initialValue: user.name,
            enabled: false,
            decoration: new InputDecoration(
              prefixIcon: Icon(Icons.contact_mail),
              labelText: "Enter Name",
              hintText: "Name",
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
            initialValue: user.email,
            enabled: false,
            decoration: new InputDecoration(
              prefixIcon: Icon(Icons.contact_mail),
              labelText: "Enter Email",
              hintText: "Email",
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
            initialValue: user.phone,
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
            initialValue: user.password,
            enabled: false,
            // controller: _carPlateController,
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

      ],
    );
  }
}