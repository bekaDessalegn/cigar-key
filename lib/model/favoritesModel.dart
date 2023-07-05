List<Favorites> FavoritesFromList(List<dynamic> str) =>
    List<Favorites>.from(str.map((x) => Favorites.fromJson(x)));

class Favorites {
  Favorites(
      {this.Brand = "",
      this.Name = "",
      this.Number = "",
      this.Description = "",
      this.Image = "",
      // this.QRCode = "",
      this.Strength = "",
      this.Shape = "",
      this.Color = "",
      this.Country = "",
      this.Flavor = "",
      this.Size = "",
      this.Rank = 0,
      this.CountryFlag = ""});

  String Brand;
  String Name;
  String Number;
  String Description;
  String Image;
  // String QRCode;
  String Strength;
  String Shape;
  String Color;
  String Country;
  String Flavor;
  String Size;
  int Rank;
  String CountryFlag;

  factory Favorites.fromJson(Map<String, dynamic> json) => Favorites(
      Brand: json["Brand"],
      Name: json["Name"],
      Number: json["Number"],
      Description: json["Description"],
      Image: json["Image"],
      // QRCode: json["QRCode"],
      Strength: json["Strength"],
      Shape: json["Shape"],
      Color: json["Color"],
      Country: json["Country"],
      Flavor: json["Flavor"],
      Size: json["Size"],
      Rank: json["Rank"],
      CountryFlag: json["CountryFlag"]);
}
