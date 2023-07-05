import 'package:get/get.dart';
import 'package:cigarKey/model/loungesModel.dart';

Lounges lounges = new Lounges();

class LoungesController extends GetxController {
  List listFiltersAdd = [];
  List listFilters = [];

  final LoungeId = lounges.LoungeId.obs;
  final Image = lounges.Image.obs;
  final Name = lounges.Name.obs;
  final Street = lounges.Street.obs;
  final City = lounges.City.obs;
  final State = lounges.State.obs;
  final ZipCode = lounges.ZipCode.obs;
  final Country = lounges.Country.obs;
  final Phone = lounges.Phone.obs;
  final HasSittings = lounges.HasSittings.obs;
  final ServesFood = lounges.ServesFood.obs;
  final AllowsBYOFood = lounges.AllowsBYOFood.obs;
  final ServesDrinks = lounges.ServesDrinks.obs;
  final AllowsBYODrinks = lounges.AllowsBYODrinks.obs;
  final Atmosphere = lounges.Atmosphere.obs;
  final Menu = lounges.Menu.obs;
  final IsCigarSubscriptionActive = lounges.IsCigarSubscriptionActive.obs;
  final WebSite = lounges.WebSite.obs;
  final Latitude = lounges.Latitude.obs;
  final Longitude = lounges.Longitude.obs;
  List get listFilter => listFiltersAdd;

  void searchLounges(String keyword, bool searching) {
    if (searching) {
      listFiltersAdd = listFilters
          .where((lounge) => lounge["Name"]
              .toString()
              .toUpperCase()
              .contains(keyword.toUpperCase()))
          .toList();
    } else {
      listFilters = listFiltersAdd;
    }

    Future.delayed(Duration.zero, () {
      update();
    });
  }

  void filterLounges(bool food, bool drinks, bool filtering) {
    if (filtering) {
    food
        ? drinks
            ? listFiltersAdd = listFilters
                .where((lounge) =>
                    lounge["ServesFood"] == true &&
                    lounge["ServesDrinks"] == true)
                .toList()
            : listFiltersAdd = listFilters
                .where((lounge) =>
                    lounge["ServesFood"] == true &&
                    lounge["ServesDrinks"] == false)
                .toList()
        : listFiltersAdd = listFilters
            .where((lounge) =>
                lounge["ServesFood"] == false &&
                lounge["ServesDrinks"] == false)
            .toList();
    }

  }

  void setList(lounges) {
    listFiltersAdd = lounges;
    Future.delayed(Duration(milliseconds: 20), () {
      update();
    });
  }

  void setLoungeId(String value) => LoungeId.value = value;
  void setImage(String value) => Image.value = value;
  void setName(String value) => Name.value = value;
  void setStreet(String value) => Street.value = value;
  void setCity(String value) => City.value = value;
  void setState(String value) => State.value = value;
  void setZipCode(String value) => ZipCode.value = value;
  void setCountry(String value) => Country.value = value;
  void setPhone(String value) => Phone.value = value;
  void setHasSittings(bool value) => HasSittings.value = value;
  void setServesFood(bool value) => ServesFood.value = value;
  void setBYOF(bool value) => AllowsBYOFood.value = value;
  void setServesDrinks(bool value) => ServesDrinks.value = value;
  void setBYOD(bool value) => AllowsBYODrinks.value = value;

  void deleteInfo() {
    LoungeId.value = "";
    Image.value = "";
    Name.value = "";
    Street.value = "";
    City.value = "";
    State.value = "";
    ZipCode.value = "";
    Country.value = "";
    Phone.value = "";
    HasSittings.value = false;
    ServesFood.value = false;
    AllowsBYOFood.value = false;
    ServesDrinks.value = false;
    AllowsBYODrinks.value = false;
    Atmosphere.value = 0;
    Menu.value = "";
    IsCigarSubscriptionActive.value = true;
    WebSite.value = "";
    Latitude.value = "";
    Longitude.value = "";
  }
}
