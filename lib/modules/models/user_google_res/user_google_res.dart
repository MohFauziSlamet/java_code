// To parse this JSON data, do
//
//     final usersModel = usersModelFromJson(jsonString);

import 'dart:convert';

UserGoogleRes userGoogleResFromJson(String str) =>
    UserGoogleRes.fromJson(json.decode(str));

String userGoogleResToJson(UserGoogleRes data) => json.encode(data.toJson());

class UserGoogleRes {
  UserGoogleRes({
    this.uid,
    this.name,
    this.email,
    this.photoURL,
    this.creationTime,
    this.lastSignInTime,
    this.updatedAt,
  });

  String? uid;
  String? name;
  String? email;
  String? photoURL;
  String? creationTime;
  String? lastSignInTime;
  String? updatedAt;

  factory UserGoogleRes.fromJson(Map<String, dynamic> json) => UserGoogleRes(
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        photoURL: json["photoURL"],
        creationTime: json["creationTime"],
        lastSignInTime: json["lastSignInTime"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "photoURL": photoURL,
        "creationTime": creationTime,
        "lastSignInTime": lastSignInTime,
        "updatedAt": updatedAt,
      };
}
