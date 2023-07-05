import 'package:cigarKey/model/ProductsModel.dart';
import 'package:cigarKey/utils/userPreferences.dart';
import 'package:get/get.dart';

Products products = new Products();

class ProductsController extends GetxController {
  List listaFiltersAdd = [];
  List listaFilters = [];
  final brand = products.Brand.obs;
  final name = products.Name.obs;
  final number = products.Number.obs;
  final description = products.Description.obs;
  final image = products.Image.obs;
  final strength = products.Strength.obs;
  List get listFilter => listaFiltersAdd;

  void listReport(dynamic humidor, dynamic lounge) async {
    if (humidor != null || lounge != null) {
      if (humidor) {
        listaFiltersAdd =
            listaFilters.where((i) => i["humidor"] == "yes").toList();
      }
      if (lounge) {
        listaFiltersAdd =
            listaFilters.where((i) => i["lounge"] == "yes").toList();
      }
    } else {
      listaFilters = listaFiltersAdd;
    }
    // switch (filter) {
    //   case 0:
    //     listaFilters = listaFiltersAdd;
    //     listaFiltersAdd =
    //         listaFilters.where((i) => i["humidor"] == "yes").toList();
    //     break;
    //   case 1:
    //     listaFilters = listaFiltersAdd;
    //     listaFiltersAdd =
    //         listaFilters.where((i) => i["lounge"] == "yes").toList();
    //     break;
    //   case 2:
    //     listaFiltersAdd =
    //         listaFilters.where((i) => i["humidor"] == "yes").toList();
    //     break;
    //   case 3:
    //     listaFiltersAdd =
    //         listaFilters.where((i) => i["humidor"] == "yes").toList();
    //     break;
    //   default:
    //     listaFilters = listaFiltersAdd;
    // }
    Future.delayed(Duration(milliseconds: 20), () {
      update();
    });
  }

  void setList(report) {
    listaFiltersAdd = report;
    Future.delayed(Duration(milliseconds: 20), () {
      update();
    });
  }

  void searchProducts(String keyword, bool searching) {
    if (searching) {
      listaFiltersAdd = listaFilters
          .where((product) => (product.Name.toString()
                  .toUpperCase()
                  .contains(keyword.toUpperCase()) ||
              (product.Brand.toString()
                  .toUpperCase()
                  .contains(keyword.toUpperCase()))))
          .toList();
    } else {
      listaFilters = listaFiltersAdd;
    }

    Future.delayed(Duration.zero, () {
      update();
    });
  }

  void searchSuggestions(String keyword, bool searching) {
    if (searching) {
      listaFiltersAdd = listaFilters
          .where((product) => (product["Name"]
                  .toString()
                  .toUpperCase()
                  .contains(keyword.toUpperCase()) ||
              (product["Brand"]
                  .toString()
                  .toUpperCase()
                  .contains(keyword.toUpperCase()))))
          .toList();
    } else {
      listaFilters = listaFiltersAdd;
    }

    Future.delayed(Duration.zero, () {
      update();
    });
  }

  void setBrand(String brandValue) => brand.value = brandValue;
  void setName(String nameValue) => name.value = nameValue;
  void setNumber(String numberValue) => number.value = numberValue;
  void setDescription(String descriptionValue) =>
      description.value = descriptionValue;
  void setImage(String imageValue) => image.value = imageValue;
  void setStrength(String strengthValue) => strength.value = strengthValue;

  void deleteInfo() {
    brand.value = '';
    name.value = '';
    number.value = '';
    description.value = '';
    image.value = '';
    strength.value = '';
  }
}
