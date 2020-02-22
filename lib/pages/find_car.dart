import 'dart:convert';
import 'package:car_app/config/api.dart';
import 'package:car_app/models/car.dart';
import 'package:car_app/pages/car_park.dart';
import 'package:car_app/pages/login.dart';
import 'package:car_app/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FindCar extends StatefulWidget {
  @override
  _FindCarState createState() => _FindCarState();
}

class _FindCarState extends State<FindCar> {

  final TextEditingController _filterController = TextEditingController();

  String _searchText= "";

  List names =  List();

  List filteredNames =  List();

  void _getNames() async {
    final response = await http.get(Url.domainUrl + "show_info");
    print(response.body);
   // List tempList = new List();
    Iterable list = json.decode(response.body);
    List <Car> carList = list.map((model)=>Car.fromJson(model)).toList();


    setState(() {
      names = carList;
      filteredNames = names;
    });
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i].plateNumber.toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index].plateNumber),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CarPark(plateNumber: filteredNames[index].plateNumber,)),
            );
          },
        );
      },
    );
  }

  _FindCarState() {
    _filterController.addListener(() {
      if (_filterController.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filterController.text;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('called');
    _getNames();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(title: Text('Search Car', style: CustomStyles.orangeTextStyle,),
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

        body: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left:15.0, right: 15.0),
              child: Container(
                padding: EdgeInsets.only(left: 20.0),
                height: 70.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.grey,
                ),
              child:Center(
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  controller: _filterController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    hintText: 'Enter the Plate Number',
                    hintStyle: TextStyle(
                        fontFamily: 'Opensans',
                        fontSize: 15.0,
                        color: Colors.white.withOpacity(0.7)),
                  ),
                ),
              ),
    ),
            ),
        _buildList(),
          ],
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