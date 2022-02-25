// To parse this JSON data, do
//
//     final relative = relativeFromJson(jsonString);

import 'dart:convert';

Relative relativeFromJson(String str) => Relative.fromJson(json.decode(str));

Relative returnRelative(Map<String, dynamic> json) {
  return Relative(
    uuid: json["uuid"],
    relation: json["relation"],
    relationId: json["relationId"],
    firstName: json["firstName"],
    middleName: json["middleName"],
    lastName: json["lastName"],
    fullName: json["fullName"],
    gender: json["gender"],
    dateAndTimeOfBirth: DateTime.parse(json["dateAndTimeOfBirth"]),
    birthDetails: BirthDetails.fromJson(json["birthDetails"]),
    birthPlace: BirthPlace.fromJson(json["birthPlace"]),
  );
}

String relativeToJson(Relative data) => json.encode(data.toJson());

class Relative {
  Relative({
    required this.uuid,
    required this.relation,
    required this.relationId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.fullName,
    required this.gender,
    required this.dateAndTimeOfBirth,
    required this.birthDetails,
    required this.birthPlace,
  });

  String uuid;
  String relation;
  int relationId;
  String firstName;
  dynamic middleName;
  String lastName;
  String fullName;
  String gender;
  DateTime dateAndTimeOfBirth;
  BirthDetails birthDetails;
  BirthPlace birthPlace;

  factory Relative.fromJson(Map<String, dynamic> json) => Relative(
        uuid: json["uuid"],
        relation: json["relation"],
        relationId: json["relationId"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        fullName: json["fullName"],
        gender: json["gender"],
        dateAndTimeOfBirth: DateTime.parse(json["dateAndTimeOfBirth"]),
        birthDetails: BirthDetails.fromJson(json["birthDetails"]),
        birthPlace: BirthPlace.fromJson(json["birthPlace"]),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "relation": relation,
        "relationId": relationId,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "fullName": fullName,
        "gender": gender,
        "dateAndTimeOfBirth": dateAndTimeOfBirth.toIso8601String(),
        "birthDetails": birthDetails.toJson(),
        "birthPlace": birthPlace.toJson(),
      };
}

class BirthDetails {
  BirthDetails({
    required this.dobYear,
    required this.dobMonth,
    required this.dobDay,
    required this.tobHour,
    required this.tobMin,
    required this.meridiem,
  });

  int dobYear;
  int dobMonth;
  int dobDay;
  int tobHour;
  int tobMin;
  String meridiem;

  factory BirthDetails.fromJson(Map<String, dynamic> json) => BirthDetails(
        dobYear: json["dobYear"],
        dobMonth: json["dobMonth"],
        dobDay: json["dobDay"],
        tobHour: json["tobHour"],
        tobMin: json["tobMin"],
        meridiem: json["meridiem"],
      );

  Map<String, dynamic> toJson() => {
        "dobYear": dobYear,
        "dobMonth": dobMonth,
        "dobDay": dobDay,
        "tobHour": tobHour,
        "tobMin": tobMin,
        "meridiem": meridiem,
      };
}

class BirthPlace {
  BirthPlace({
    required this.placeName,
    required this.placeId,
  });

  String placeName;
  String placeId;

  factory BirthPlace.fromJson(Map<String, dynamic> json) => BirthPlace(
        placeName: json["placeName"],
        placeId: json["placeId"],
      );

  Map<String, dynamic> toJson() => {
        "placeName": placeName,
        "placeId": placeId,
      };
}
