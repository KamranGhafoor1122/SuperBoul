// To parse this JSON data, do
//
//     final appUser = appUserFromMap(jsonString);

import 'dart:convert';

AppUser appUserFromMap(String str) => AppUser.fromMap(json.decode(str));

String appUserToMap(AppUser data) => json.encode(data.toMap());

class AppUser {
  AppUser({
    this.success,
    this.message,
    this.user,
    this.accessToken,
    this.tokenType,
  });

  bool? success;
  String? message;
  User? user;
  String? accessToken;
  String? tokenType;

  factory AppUser.fromMap(Map<String, dynamic> json) => AppUser(
        success: json["success"],
        message: json["message"],
        user: User.fromMap(json["user"]),
        accessToken: json["access_token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "user": user!.toMap(),
        "access_token": accessToken,
        "token_type": tokenType,
      };
}

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.pushNotification,
    this.lat,
    this.long,
    this.dob,
    this.fcmToken,
    this.profilePic,
    this.referral,
    this.credit,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  int? pushNotification;
  double? lat;
  double? long;
  DateTime? dob;
  String? fcmToken;
  String? profilePic;
  String? referral;
  String? credit;

  factory User.fromMap(Map<String, dynamic> json) => User(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      phone: json["phone"],
      pushNotification: json["push_notification"],
      lat: json["lat"].toDouble(),
      long: json["long"].toDouble(),
      dob: json["dob"] != 0? DateTime.parse(json["dob"]):null,
      fcmToken: json["fcm_token"],
      profilePic: json["profile_pic"],
      referral: json["my_referral"].toString(),
      credit: json.containsKey("credit") ? json["credit"].toString() : "0");

  Map<String, dynamic> toMap() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "push_notification": pushNotification,
        "lat": lat,
        "long": long,
        "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "fcm_token": fcmToken,
        "profile_pic": profilePic,
      };
}
