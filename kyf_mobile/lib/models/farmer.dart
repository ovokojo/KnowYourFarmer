// To parse this JSON data, do
//
//     final farmer = farmerFromJson(jsonString);

import 'dart:convert';

Farmer farmerFromJson(String str) => Farmer.fromJson(json.decode(str));

String farmerToJson(Farmer data) => json.encode(data.toJson());

class Farmer {
  Farmer({
    required this.uid,
    required this.name,
    required this.phone,
    this.dateOfBirth,
    this.address,
    this.idNumber,
    this.farmGpsLocation,
    this.farmSize,
  });

  String uid;
  String name;
  String phone;
  String? dateOfBirth;
  String? address;
  String? idNumber;
  String? farmGpsLocation;
  String? farmSize;

  factory Farmer.fromJson(Map<String, dynamic> json) => Farmer(
        uid: json["uid"],
        name: json["name"],
        phone: json["phone"],
        dateOfBirth: json["dateOfBirth"],
        address: json["address"],
        idNumber: json["idNumber"],
        farmGpsLocation: json["farmGpsLocation"],
        farmSize: json["farmSize"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "phone": phone,
        "dateOfBirth": dateOfBirth,
        "address": address,
        "idNumber": idNumber,
        "farmGpsLocation": farmGpsLocation,
        "farmSize": farmSize,
      };

  @override
  String toString() {
    // TODO: implement toString
    return "${name} ${phone}";
  }
}
