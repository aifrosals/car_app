import 'package:car_app/models/car.dart';
import 'package:car_app/models/user.dart';
import 'package:car_app/pages/add_car.dart';
import 'package:car_app/pages/add_user.dart';
import 'package:car_app/pages/capture_image.dart';
import 'package:car_app/pages/car_list.dart';
import 'package:car_app/pages/car_park.dart';
import 'package:car_app/pages/find_car.dart';
import 'package:car_app/pages/login.dart';
import 'package:car_app/pages/login_as.dart';
import 'package:car_app/pages/manage_car.dart';
import 'package:car_app/pages/menu.dart';
import 'package:car_app/pages/user_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
      ),
      home: UserList(),
    //  MyHomePage(title: 'Vehicle Park',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  Future<Null> checkIsLogin() async {

    String _type = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();


    _type = prefs.getString("type");

    print(_type);

     if (_type != "" && _type != null) {
      print("alreay login.");
      if(_type == 'user'){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FindCar()),
        );
      }
      else if(_type == 'admin'){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Menu()),
        );
      }
    else {
      print('the type is $_type');
      }

    }
    else
    {
      //  replace it with the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginAS()),
      );

    }

  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsLogin();
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
         child: CircularProgressIndicator(),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
      ),
    );
  }
}
