import 'dart:convert';
import 'package:car_app/config/api.dart';
import 'package:car_app/models/car.dart';
import 'package:car_app/pages/manage_car.dart';
import 'package:car_app/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CarList extends StatefulWidget {
  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  Future<List<Car>> carList;

  Future<List<Car>> getCarList() async{
    try {
      final response = await http.get(Url.domainUrl + "show_info");
      print('Response body:${response.body}');
      Iterable list = json.decode(response.body);

      List <Car> carList = list.map((model)=>Car.fromJson(model)).toList();
     //carList.forEach((f)=>print(f.parkingLimit));
      return carList;
    }
    catch (e) {
      print('error in car list $e');
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carList = getCarList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cars', style: CustomStyles.orangeTextStyle,),
        backgroundColor: Colors.white12,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.orange),
        centerTitle: true,
      ),
     body:
        FutureBuilder<List<Car>>(
          future: carList,
          builder: (context, snapshot) {
               if(snapshot.hasData) {
                 return ListView.builder(
                   itemCount: snapshot.data.length,
                     itemBuilder: (BuildContext context, int index) {
                     //print(snapshot.data[index].plateNumber);
                       return (CarListTile(car: snapshot.data[index]));
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


class CarListTile extends StatelessWidget {
 final Car car;

  CarListTile({this.car});

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
              child: Icon(Icons.directions_car, color: Colors.white),
            ),
            title: Text(
              car.carHolderName,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(car.phoneNumber, style: TextStyle(color: Colors.white)),
                Text(car.plateNumber, style: TextStyle(color: Colors.white)),
              ],
            ),
            trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ManageCar(car: this.car,)),
            );
          },
        ),
      ),
    );
  }
}