import 'package:get/get.dart';
import '../model/favoritesModel.dart';

class FavoritesController extends GetxController {
  List<Favorites> filteredList = [];
  List<Favorites> filtersList = [];

  List<Favorites> get listFilter => filteredList;

  void listFavorites() async {
    //FILTER BY ?
    update();
  }

  void setList(Favorite) {
    this.filteredList = Favorite;
    update();
  }
}
