import 'dart:convert';
import 'dart:ffi';

Profile profileFromJson(String str) => profileFromJson(json.decode(str));

class Profile {
  Profile({
    this.FirstName = "",
    this.LastName = "",
    this.Email = "",
    this.PhoneNumber = "",
    this.ZipCode = "",
    this.ProfileImagePath = "",
    this.gender = "",
    this.notification = false,
    this.TutorialTaken = false,
    this.travelActive = false,
    this.travelDistance = 0,
    this.rank = "",
  });

  String FirstName;
  String LastName;
  String Email;
  String PhoneNumber;
  String ZipCode;
  String ProfileImagePath;
  String gender;
  bool TutorialTaken;
  bool notification;
  bool travelActive;
  int travelDistance;
  String rank;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        FirstName: json["FirstName"] != null ? json["FirstName"] : "",
        LastName: json["LastName"] != null ? json["LastName"] : "",
        Email: json["Email"],
        PhoneNumber: json["PhoneNumber"] != null ? json["PhoneNumber"] : "",
        ZipCode: json["ZipCode"] != null ? json["ZipCode"] : "",
        ProfileImagePath:
            json["ProfileImagePath"] != null ? json["ProfileImagePath"] : "",
        gender: json["Gender"] != null ? json["Gender"] : "",
        TutorialTaken: json["TutorialTaken"],
        notification: json["Config"]["Notifications"],
        travelActive: json["Config"]["TravelMode"]["Active"],
        travelDistance: json["Config"]["TravelMode"]["Distance"],
        rank: json["Rank"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "FirstName": FirstName,
        "LastName": LastName,
        "Email": Email,
        "PhoneNumber": PhoneNumber,
        "ZipCode": ZipCode,
        "ProfileImagePath": ProfileImagePath,
        "Gender": gender,
        "TutorialTaken": TutorialTaken,
        "Rank": rank,
      };
}
