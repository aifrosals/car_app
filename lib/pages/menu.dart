import 'package:car_app/pages/add_car.dart';
import 'package:car_app/pages/add_user.dart';
import 'package:car_app/pages/car_list.dart';
import 'package:car_app/pages/find_car.dart';
import 'package:car_app/pages/login.dart';
import 'package:car_app/pages/user_list.dart';
import 'package:car_app/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height - kToolbarHeight;

    return Scaffold(
      appBar: AppBar(title: Text('Car', style: CustomStyles.orangeTextStyle,),
        backgroundColor: Colors.white12,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.orange),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app,color: Colors.orange,), onPressed: (){
            _deletePrefsOnLogOut();
          },tooltip: 'Log Out',)

        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(child: Text('Admin Pannel', style: TextStyle(color: Colors.white),)),
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
            ),
            ListTile(
              title: Text('Add User'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddUser())
                );
              },
            ),
            ListTile(
              title: Text('Add Car'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddCar())
                );
              },
            ),
            ListTile(
              title: Text('Manage Users'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserList())
                );
              },
            ),
            ListTile(
              title: Text('Manage Cars'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CarList())
                );
              },
            ),
            ListTile(
              title: Text('Manage Car Parking'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FindCar())
                );
              },
            ),

            ListTile(
              title: Text('Log Out'),
              onTap: () {
                _deletePrefsOnLogOut();
              },
            ),


          ],
        ),
      ),
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: <Widget>[
            SizedBox(height: height * 0.17,),
            Container(
             // color: Colors.purple,
              height: height * 0.28,
              width: width * 0.85,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 100,
                    child: Container(
                      height: height * 20,
                      child: Card(
                        color: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft:  Radius.circular(40),
                              bottomLeft:  Radius.circular(40),
                            ),
                          ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AddCar())
                            );
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.directions_car,color: Colors.white,
                                  size: height / 12,
                                ),
                                Text('Add Car', style:TextStyle(color: Colors.white),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 100,
                    child: Container(
                      height: height * 20,
                      child: Card(
                          color: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight:  Radius.circular(40),
                              bottomRight:  Radius.circular(40),

                            ),
                          ),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CarList())
                            );

                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.directions_car,color: Colors.white,
                                      size: height / 16,
                                    ),
                                    Icon(Icons.build,color: Colors.white,
                                      size: height / 18,
                                    ),
                                  ],
                                ),
                                Text('Manage Car', style:TextStyle(color: Colors.white),)
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
            SizedBox(height: height * 0.03,),
            Container(
              // color: Colors.purple,
              height: height * 0.28,
              width: width * 0.85,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 100,
                    child: Container(
                      height: height * 20,
                      child: Card(
                        color: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft:  Radius.circular(40),
                            bottomLeft:  Radius.circular(40),
                          ),
                        ),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AddUser())
                            );
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.account_circle,color: Colors.white,
                                  size: height / 12,
                                ),
                                Text('Add User', style:TextStyle(color: Colors.white),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 100,
                    child: Container(
                      height: height * 20,
                      child: Card(
                        color: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight:  Radius.circular(40),
                            bottomRight:  Radius.circular(40),

                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => UserList())
                            );

                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.account_circle,color: Colors.white,
                                      size: height / 16,
                                    ),
                                    Icon(Icons.build,color: Colors.white,
                                      size: height / 18,
                                    ),
                                  ],
                                ),
                                Text('Manage User', style:TextStyle(color: Colors.white),)
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
          ],
        ),
      ),
    );
  }
  void _deletePrefsOnLogOut () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('type');
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext ctx) => Login()));
  }
}