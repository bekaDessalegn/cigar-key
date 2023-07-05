List<Products> ProductsFromList(List<dynamic> str) =>
    List<Products>.from(str.map((x) => Products.fromJson(x)));

class Products {
  Products(
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
      this.CountryFlag = "",
      this.Rank = 0});

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
  String CountryFlag;
  int Rank;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
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
        CountryFlag: json["CountryFlag"],
        Rank: json["Rank"],
      );
}
