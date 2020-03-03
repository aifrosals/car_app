import 'dart:convert';

import 'package:car_app/config/api.dart';
import 'package:car_app/models/user.dart';
import 'package:car_app/pages/manage_user.dart';
import 'package:car_app/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {

Future<List<User>> userList;

@override
void initState() {
  // TODO: implement initState
  super.initState();
  userList = getUserList();
}

Future<List<User>> getUserList() async{
  try {
      //List<User> user = [];
    final response = await http.get(Url.domainUrl + "show_user");
    print('Response body:${response.body}');

    Iterable list = json.decode(response.body);
    //print('hello ${json.decode(response.body)}');
    List <User> mUserList = list.map((model)=>User.fromJson(model)).toList();
    mUserList.forEach((f)=>print(f.email));
//    var rep = json.decode(response.body);
//   print((rep[0]['email']));
//   print(rep.length);
//   User user = User.fromJson(rep[0]);
//   print(user.phone);
//    for(int i=0; i<rep.length ; i++){
//      user.add(User.fromJson(rep[i]));
//    }
//    user.forEach((f)=>print(f.email));
//    return user;
  return mUserList;
  }
  catch (e) {
    print('error in user list $e');
    return null;
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User', style: CustomStyles.orangeTextStyle,),
        backgroundColor: Colors.white12,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.orange),
        centerTitle: true,
      ),
      body:
      FutureBuilder<List<User>>(
        future: userList,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  //print(snapshot.data[index].plateNumber);
                 return (UserListTile(user: snapshot.data[index]));
                  //return null;
                }
            );
          }
//               else if(snapshot.hasData){
//                 return null;
//               }

          return Center(child: CircularProgressIndicator());

        },
      ),
    );
  }
}

class UserListTile extends StatelessWidget {
  final User user;

  UserListTile({this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(

                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.assignment_ind, color: Colors.white),
          ),
          title: Text(
            user.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(user.email, style: TextStyle(color: Colors.white)),
            ],
          ),
          trailing:
          Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ManageUser(user: this.user,)),
            );
          },
        ),
      ),
    );
  }
}