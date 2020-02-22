import 'dart:convert';
import 'package:car_app/config/api.dart';
import 'package:car_app/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class CarPark extends StatefulWidget {
  final String plateNumber;

  CarPark({this.plateNumber});

  @override
  _CarParkState createState() => _CarParkState();
}

String getTodayDate() {
  var date = DateFormat.yMMMMEEEEd().format(DateTime.now());
  print(date.toString());
  return date;
}

class _CarParkState extends State<CarPark> {
  String btnText = "";
  DailyParkTime parkTime = DailyParkTime();
  Future<DailyParkTime> parkTime1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getBtnText(widget.plateNumber);
   getParkingData(widget.plateNumber);
  }
  void getBtnText(String platNumber) async {
    final response=await http.get(Url.domainUrl+"car_park"+"&plate="+platNumber);
    print('Response body:${response.body}');
    if(response.body == 'give park in')
    {
      setState(() {
        btnText = 'Start Parking';
      });
    }
    else if (response.body == 'give park out')
    {
      setState(() {
        btnText = 'End Parking';
      });

    }
    else if (response.body == 'already park')
    {
      setState(() {
        btnText = 'Parked';
      });
    }
  }
  void parkFunc(String platNumber) async {
    String request;
    if(btnText == 'Start Parking'){
      request = 'Start';
      print(request);
      print(platNumber);
    }
    else if(btnText == 'End Parking') {
      request ='End';
      print(request);
    }
    try {
      final response = await http.get(
          Url.domainUrl + "add_car_parking" + "&plate=" + platNumber +
              "&request=" + request);
      print('Response body:${response.body}');
      if (response.body == 'give park out') {
        setState(() {
          btnText = 'End Parking';
        });
      }
      else if (response.body == 'already park') {
        setState(() {
          btnText = 'Parked';
        });
      }
    }
    catch(e)
    {
      print(e);
    }
  }

  Future<DailyParkTime> getParkingData(String numberPlate) async
  {
    try {
      DailyParkTime details = DailyParkTime();
      final response = await http.get(
          Url.domainUrl + "show_info_park" + "&plate=" + numberPlate);
      print('Response body:${response.body}');
      if(response.body.isEmpty || response.body ==null || response.body == 'null')
        {
          print('body of response');
          details.startTime="00:00:00";
          details.endTimme="00:00:00";
          return details;
          //parkTime.startTime = '0:00';
         // print(parkTime.startTime);
        }
      else {
        var jsonResponse = json.decode(response.body);
         details = DailyParkTime.fromJason(jsonResponse[0]);
        return details;
//        setState(() {
//          parkTime.startTime = convertTimeFromString(details.startTime);
//          parkTime.endTimme = convertTimeFromString(details.endTimme);
//        });
   //     print(convertTimeFromString(details.startTime));
      }
    }
    catch (e) {
      print("this is $e");
      return null;

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
       widget.plateNumber,
        style: CustomStyles.orangeTextStyle,),
        backgroundColor: Colors.white12,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.orange),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            Center(child: Text(getTodayDate(), style: TextStyle(color: Colors.purple),)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 150,
                child: FutureBuilder(
                  future: getParkingData(widget.plateNumber),
                  builder: (context,snapshot)
                  {
                    if(snapshot.hasData){
                      return
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                height: 200,
                                child: Card(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Center(child: FittedBox(fit: BoxFit.contain,child: Text('Park at',textAlign: TextAlign.center,))),
                                      Center(child: FittedBox(fit: BoxFit.contain,child: Text(convertTimeFromString(snapshot.data.startTime),textAlign: TextAlign.center,))),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(child: Container(
                                height: 200,
                                child: Card(
                                  child:
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Center(child: FittedBox(fit: BoxFit.contain,child: Text('Stop Parking At',textAlign: TextAlign.center,))),
                                      Center(child: FittedBox(fit: BoxFit.contain,child: Text(convertTimeFromString(snapshot.data.endTimme),textAlign: TextAlign.center,))),
                                    ],
                                  ),
                                ),
                            ),
                            ),
                          ],
                        );
                    }
                    else if(snapshot.hasError){
                      print('Erroruyhjhjjjjjjjjjjjjjjjjjjjjjhjhjjjjj');
                      return Container();
                    }
                    else {
                      return
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                height: 200,
                                child: Card(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Center(child: FittedBox(fit: BoxFit.contain,child: Text('Park at',textAlign: TextAlign.center,))),
                                      Center(child: FittedBox(fit: BoxFit.contain,child: Text('00:00:00',textAlign: TextAlign.center,))),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(child: Container(
                              height: 200,
                              child: Card(
                                child:
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Center(child: FittedBox(fit: BoxFit.contain,child: Text('Stop Parking At',textAlign: TextAlign.center,))),
                                    Center(child: FittedBox(fit: BoxFit.contain,child: Text('00:00:00',textAlign: TextAlign.center,))),
                                  ],
                                ),
                              ),
                            ),
                            ),
                          ],
                        );

                    }
                  }
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    parkFunc(widget.plateNumber);
                    getParkingData(widget.plateNumber);
                  },
                  splashColor: Colors.purple,
                  highlightColor: Colors.orange,
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey),
//                        boxShadow: [BoxShadow(
//                          color: Colors.white,
//                          blurRadius: 5.0,
//                        ),]
                    ),
                    child: Center(
                      child: Text(
                        btnText,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

class DailyParkTime{
  String startTime;
  String endTimme;

  DailyParkTime({this.startTime,
  this.endTimme});

  factory DailyParkTime.fromJason(Map<String, dynamic> parsedJson){
    return DailyParkTime(
        startTime: parsedJson['start_park']==null? '00:00:00': parsedJson['start_park'],
        endTimme: parsedJson['end_park']==null? '00:00:00' : parsedJson['end_park'],
    );
  }
}

String convertTimeFromString(String strDate){
  if(strDate == "00:00:00")
  {
    return strDate;
  }
  if(strDate==null || strDate.isEmpty)
  {
    return strDate="--";
  }
  else
  {
    DateTime todayDate = DateTime.parse(strDate);
    String formattedDate = DateFormat('hh:mm a').format(todayDate);
    return formattedDate;
  }
  //return "error";
}