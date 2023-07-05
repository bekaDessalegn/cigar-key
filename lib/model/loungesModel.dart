List<Lounges> LoungesFromList(List<dynamic> str) =>
    List<Lounges>.from(str.map((x) => Lounges.fromJson(x)));

class Lounges {
  Lounges({
    this.LoungeId = "",
    this.Image = "",
    this.Name = "",
    this.Street = "",
    this.City = "",
    this.State = "",
    this.ZipCode = "",
    this.Country = "",
    this.Phone = "",
    this.HasSittings = false,
    this.ServesFood = false,
    this.AllowsBYOFood = false,
    this.ServesDrinks = false,
    this.AllowsBYODrinks = false,
    this.Atmosphere = 0,
    this.Menu = "",
    this.IsCigarSubscriptionActive = true,
    this.WebSite = "",
    this.Latitude = "",
    this.Longitude = "",
  });

  String LoungeId;
  String Image;
  String Name;
  String Street;
  String City;
  String State;
  String ZipCode;
  String Country;
  String Phone;
  bool HasSittings;
  bool ServesFood;
  bool AllowsBYOFood;
  bool ServesDrinks;
  bool AllowsBYODrinks;
  int Atmosphere;
  String Menu;
  bool IsCigarSubscriptionActive;
  String WebSite;
  String Latitude;
  String Longitude;

  factory Lounges.fromJson(Map<String, dynamic> json) => Lounges(
        LoungeId: json["LoungeId"],
        Image: json["Image"],
        Name: json["Name"],
        Street: json["Street"],
        City: json["City"],
        State: json["State"],
        ZipCode: json["ZipCode"],
        Country: json["Country"],
        Phone: json["Phone"],
        HasSittings: json["HasSittings"],
        ServesFood: json["ServesFood"],
        AllowsBYOFood: json["AllowsBYOFood"],
        ServesDrinks: json["ServesDrinks"],
        AllowsBYODrinks: json["AllowsBYODrinks"],
        Atmosphere: json["Atmosphere"],
        Menu: json["Menu"],
        IsCigarSubscriptionActive: json["IsCigarSubscriptionActive"],
        WebSite: json["WebSite"],
        Latitude: json["Latitude"],
        Longitude: json["Longitude"],
      );
}
