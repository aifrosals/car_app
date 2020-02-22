class Car {
   String carHolderName;
   String phoneNumber;
   String plateNumber;
   String parkingLimit;



     Car({this.carHolderName, this.phoneNumber, this.plateNumber, this.parkingLimit});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      carHolderName: json["name"],
      phoneNumber: json["number"],
      plateNumber: json["plate"],
        parkingLimit: json["parking_limit"]
//      startPark: json["start_park"],
//      endPark: json["end_park"],
    );
  }
}