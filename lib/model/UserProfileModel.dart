class UserProfileModel {
  final String FirstName;
  final String LastName;
  final String Email;
  final String PhoneNumber;
  final String Gender;
  final String ZipCode;
  String? ProfileImage;

  UserProfileModel(
      {required this.FirstName,
      required this.LastName,
      required this.Email,
      required this.PhoneNumber,
      required this.Gender,
      required this.ZipCode,
      this.ProfileImage});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
          FirstName: json["extension_FirstName"],
          LastName: json["extension_LastName"],
          Email: json["emails"][0],
          PhoneNumber: json["extension_PhoneNumber"].toString(),
          Gender: json["extension_Gender"],
          ZipCode: json["extension_ZipCode"].toString(),
          ProfileImage: json["extension_ProfileImage"]);

  Map<String, dynamic> toJson() => {
    "FirstName" : FirstName,
    "LastName" : LastName,
    "Email" : Email,
    "PhoneNumber" : PhoneNumber,
    "Gender" : Gender,
    "ZipCode" : ZipCode,
    "ProfileImage" : ProfileImage
  };
}
