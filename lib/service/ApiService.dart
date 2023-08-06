import 'dart:async';
import 'dart:convert';
// import 'package:flutter_config/flutter_config.dart';
// import 'package:get/get.dart';
import 'package:cigarKey/controllers/productsController.dart';
import 'package:cigarKey/controllers/userController.dart';
import 'package:cigarKey/controllers/QuestionnaireController.dart';
import 'package:cigarKey/controllers/FavoritesController.dart';
import 'package:cigarKey/model/ProductsModel.dart';
import 'package:cigarKey/model/ProfileModel.dart';
import 'package:cigarKey/model/QuestionnaireModel.dart';
import 'package:cigarKey/model/favoritesModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:cigarKey/utils/.env.dart' as env;

class ApiService {
  static UserController user = Get.put(UserController());
  static FavoritesController favorites = Get.put(FavoritesController());
  static ProductsController productBy = Get.put(ProductsController());
  static QuestionnaireController questionnaire =
      Get.put(QuestionnaireController());

  static Future<List<String>> createProfile(data) async {
    Map<String, String> requestHeaders = {
      'Accept': '*/*',
      'Content-Type': 'application/json',
    };
    try {
      var response = await http
          .post(
              Uri.parse(
                  "https://func-thecigarkey-dev.azurewebsites.net/api/CreateProfile"),
              headers: requestHeaders,
              body: json.encode(data))
          .timeout(const Duration(seconds: 20), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      if (response.statusCode == 200) {
        return ["200", response.body];
      } else if (response.statusCode == 400) {
        return ["400", "Profile already exsists."];
      } else {
        return ['Occurred an error Please try again'];
      }
    } catch (e) {
      return ['Occurred an error Please try again'];
    }
  }

  static Future<String> createSocial(data) async {
    Map<String, String> requestHeaders = {
      'Accept': '*/*',
      'Content-Type': 'application/json',
    };
    try {
      var response = await http
          .post(
              Uri.parse(
                  "https://func-thecigarkey-dev.azurewebsites.net/api/CreateProfile"),
              headers: requestHeaders,
              body: json.encode(data))
          .timeout(const Duration(seconds: 20), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      if (response.statusCode == 200) {
        return "200";
      } else if (response.statusCode == 400) {
        return "400";
      } else {
        return 'Occurred an error Please try again';
      }
    } catch (e) {
      return 'Occurred an error Please try again';
    }
  }

  static Future<List> allProducts(args) async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://func-thecigarkey-dev.azurewebsites.net/api/GetProducts"),
          body: json.encode(args));

      if (response.statusCode == 200) {
        var jsonList = json.decode(utf8.decode(response.bodyBytes).toString());

        List<Products> products = ProductsFromList(jsonList['products']);

        return ['200', products];
      } else {
        return ['400', "Occurred an error Please try again"];
      }
    } catch (e) {
      return ["Occurred an error Please try again"];
    }
  }

  static Future getProductById(product) async {
    Map<String, String> requestHeaders = {
      'Accept': '*/*',
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.post(
          Uri.parse(
              "https://func-thecigarkey-dev.azurewebsites.net/api/GetProducts"),
          headers: requestHeaders,
          body: jsonEncode(product));
      if (response.statusCode == 200) {
        var jsonList = json.decode(utf8.decode(response.bodyBytes).toString());

        List<Products> productById = ProductsFromList(jsonList['products']);

        if (productById.length > 1) {
          return ['400', "QR Code is not valid."];
        }

        productBy.setBrand(productById[0].Brand);
        productBy.setName(productById[0].Name);
        productBy.setNumber(productById[0].Number);
        productBy.setDescription(productById[0].Description);
        productBy.setImage(productById[0].Image);
        productBy.setStrength(productById[0].Strength);
        return ['200', productById];
      } else {
        return ['400', "Occurred an error Please try again"];
      }
    } catch (e) {
      return ["Occurred an error Please try again"];
    }
  }

  static Future<List> updateProfile(args) async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://func-thecigarkey-dev.azurewebsites.net/api/UpdateProfile"),
          body: json.encode(args));

      if (response.statusCode == 200) {
        var jsonList = json.decode(utf8.decode(response.bodyBytes).toString());
        Profile profile = Profile.fromJson(jsonList['profile']);
        user.setName(profile.FirstName);
        user.setEmail(profile.Email);
        user.setImage(profile.ProfileImagePath);
        user.setZip(profile.ZipCode);
        user.setLastName(profile.LastName);
        user.setPhone(profile.PhoneNumber);
        user.setGender(profile.gender);
        user.setTutorialTaken(profile.TutorialTaken);
        user.setNotification(profile.notification);
        user.setTravelActive(profile.travelActive);
        user.setTravelDistance(profile.travelDistance);
        if (jsonList['profile']['Rank'] <= 1.4) {
          user.setRank("Strong");
        } else if (jsonList['profile']['Rank'] >= 1.5 &&
            jsonList['profile']['Rank'] <= 2.4) {
          user.setRank("Full");
        } else if (jsonList['profile']['Rank'] >= 2.5 &&
            jsonList['profile']['Rank'] <= 3.4) {
          user.setRank("Medium");
        } else if (jsonList['profile']['Rank'] >= 3.5 &&
            jsonList['profile']['Rank'] <= 4.4) {
          user.setRank("Mild");
        } else if (jsonList['profile']['Rank'] >= 4.6 &&
            jsonList['profile']['Rank'] <= 5) {
          user.setRank("Sweet");
        }

        return ['200', "Saved successfully"];
      } else {
        return ['400', "Occurred an error Please try again"];
      }
    } catch (e) {
      return ["Occurred an error Please try again"];
    }
  }

  static Future<List> getProfile(args) async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://func-thecigarkey-dev.azurewebsites.net/api/GetProfile"),
          body: json.encode(args));

      if (response.statusCode == 200) {
        var jsonList = json.decode(utf8.decode(response.bodyBytes).toString());
        Profile profile = Profile.fromJson(jsonList['profile']);

        user.setName(profile.FirstName);
        user.setEmail(profile.Email);
        user.setImage(profile.ProfileImagePath);
        user.setZip(profile.ZipCode);
        user.setLastName(profile.LastName);
        user.setPhone(profile.PhoneNumber);
        user.setGender(profile.gender);
        user.setTutorialTaken(profile.TutorialTaken);
        user.setNotification(profile.notification);
        user.setTravelActive(profile.travelActive);
        user.setTravelDistance(profile.travelDistance);
        if (jsonList['profile']['Rank'] <= 1.4) {
          user.setRank("Strong");
        } else if (jsonList['profile']['Rank'] >= 1.5 &&
            jsonList['profile']['Rank'] <= 2.4) {
          user.setRank("Full");
        } else if (jsonList['profile']['Rank'] >= 2.5 &&
            jsonList['profile']['Rank'] <= 3.4) {
          user.setRank("Medium");
        } else if (jsonList['profile']['Rank'] >= 3.5 &&
            jsonList['profile']['Rank'] <= 4.4) {
          user.setRank("Mild");
        } else if (jsonList['profile']['Rank'] >= 4.6 &&
            jsonList['profile']['Rank'] <= 5) {
          user.setRank("Sweet");
        }
        return ['200', profile];
      } else {
        print(response);
        print(response.body);
        final data = json.decode(response.body);
        if(data["Error"]["Message"] == "Profile doesn't exsists."){
          return ['404', "Profile doesn't exsists."];
        }
        return ['400', "Occurred an error Please try again"];
      }
    } catch (e) {
      return ['500', "Occurred an error Please try again"];
    }
  }

  static Future<List> isPrefrencesNull(args) async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://func-thecigarkey-dev.azurewebsites.net/api/GetProfile"),
          body: json.encode(args));

      if (response.statusCode == 200) {
        var jsonList = json.decode(utf8.decode(response.bodyBytes).toString());

        List? preferences = jsonList['preferences'];

        return ['200', preferences == null ? true : false];
      } else {
        print(response);
        print(response.body);
        final data = json.decode(response.body);
        if(data["Error"]["Message"] == "Profile doesn't exsists."){
          return ['404', "Profile doesn't exsists."];
        }
        return ['400', "Occurred an error Please try again"];
      }
    } catch (e) {
      return ['500', "Occurred an error Please try again"];
    }
  }

  static Future<List> getFavorites(args) async {
    Map<String, dynamic> queryParams = {
      'Email': '$args',
    };
    try {
      final response = await http.post(
          Uri.parse(
              "https://func-thecigarkey-dev.azurewebsites.net/api/GetProfile"),
          body: json.encode(queryParams));

      if (response.statusCode == 200) {
        var jsonList = json.decode(utf8.decode(response.bodyBytes).toString());
        if (jsonList['favorites'] != null) {
          List<Favorites> favs = FavoritesFromList(jsonList['favorites']);

          favorites.setList(favs);
          return ['200', favs];
        } else {
          return ['200', []];
        }
      } else {
        return ['400', "Occurred an error Please try again"];
      }
    } catch (e) {
      return ['500', "Occurred an error Please try again"];
    }
  }

  static Future<List> uploadProfileImage(email, file) async {
    try {
      var request = http.MultipartRequest(
          "POST",
          Uri.parse(
              "https://func-thecigarkey-dev.azurewebsites.net/api/UploadProfileImage"))
        ..fields["Email"] = email;
      request
        ..files.add(await http.MultipartFile.fromPath("file", file.path,
            contentType: MediaType('image', 'jpg')));

      var resp = await request.send().timeout(const Duration(seconds: 80),
          onTimeout: () {
        throw TimeoutException(
            "The connection has timed out, Please try again!");
      });
      var response = await resp.stream.bytesToString();
      if (resp.statusCode == 200) {
        return ['200', response];
      } else {
        return ['400', "Occurred an error Please try again"];
      }
    } catch (e) {
      return ["Occurred an error Please try again"];
    }
  }

  static Future<List> getQuestionnaire(args) async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://func-thecigarkey-dev.azurewebsites.net/api/GetQuestionnaire"),
          body: json.encode(args));

      if (response.statusCode == 200) {
        var jsonList = json.decode(utf8.decode(response.bodyBytes).toString());
        List<dynamic> quest = (jsonList['Preferences']);
        // questionnaire.setPreferenceId(quest.preferenceId);
        // questionnaire.setType(quest.type);
        // questionnaire.setName(quest.name);
        // questionnaire.setRank(quest.rank);

        return ["200", quest];
      } else {
        return ["400", "Occurred an error Please try again"];
      }
    } catch (e) {
      return ["Occurred an error Please try again"];
    }
  }

  static Future addUserPreferences(args) async {
    try {
      final response = await http.post(
          Uri.parse(
              'https://func-thecigarkey-dev.azurewebsites.net/api/AddUserPreferences'),
          body: json.encode(args));

      if (response.statusCode == 200) {
        var jsonList = json.decode(utf8.decode(response.bodyBytes).toString());
        if (jsonList['profile']['Rank'] <= 1.4) {
          user.setRank("Strong");
        } else if (jsonList['profile']['Rank'] >= 1.5 &&
            jsonList['profile']['Rank'] <= 2.4) {
          user.setRank("Full");
        } else if (jsonList['profile']['Rank'] >= 2.5 &&
            jsonList['profile']['Rank'] <= 3.4) {
          user.setRank("Medium");
        } else if (jsonList['profile']['Rank'] >= 3.5 &&
            jsonList['profile']['Rank'] <= 4.4) {
          user.setRank("Mild");
        } else if (jsonList['profile']['Rank'] >= 4.6 &&
            jsonList['profile']['Rank'] <= 5) {
          user.setRank("Sweet");
        }
        return ["200", jsonList["profile"]];
      } else {
        return ["400", "Occurred an error. Please try again"];
      }
    } catch (e) {
      return ["Occurred an error. Please try again"];
    }
  }

  static Future addUserFavorite(args) async {
    try {
      final response = await http.post(
          Uri.parse(
              'https://func-thecigarkey-dev.azurewebsites.net/api/AddUserFavorites'),
          body: json.encode(args));

      if (response.statusCode == 200) {
        return ["200", "OK"];
      } else {
        return ["400", "Occurred an error. Please try again"];
      }
    } catch (e) {
      return ["Occurred an error. Please try again"];
    }
  }

  static Future deleteUserFavorite(args) async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://func-thecigarkey-dev.azurewebsites.net/api/DeleteUserFavorites"),
          body: json.encode(args));

      if (response.statusCode == 200) {
        return ["200", "Ok"];
      } else {
        return ["400", "Occurred an error, Please try again"];
      }
    } catch (e) {
      return ["500", "Occurred an error, Please try again"];
    }
  }

  static Future deleteUserPreferences(args) async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://func-thecigarkey-dev.azurewebsites.net/api/DeleteUserPreferences"),
          body: json.encode(args));

      if (response.statusCode == 200) {
        return ["200", "OK"];
      } else {
        return ["400", "Occurred an error, Please try again"];
      }
    } catch (e) {
      return ["500", "Occurred an error, Please try again"];
    }
  }

  static Future getLounges(args) async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://func-thecigarkey-dev.azurewebsites.net/api/GetLounges"),
          body: json.encode(args));

      if (response.statusCode == 200) {
        var jsonList = json.decode(utf8.decode(response.bodyBytes).toString());
        List<dynamic> lounges =
            (jsonList['Lounges'] != null ? jsonList['Lounges'] : []);

        return ["200", lounges];
      } else {
        return ["400", "Occurred an error, Please try again"];
      }
    } catch (e) {
      return ["500", "Occurred an error, Please try again"];
    }
  }

  static Future getGoogleLounges(lat, lng) async {
    try {
      final response = await http.get(Uri.parse(//40233.6 = 25 miles
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=cigar lounge&location=$lat,$lng&radius=${user.travelActive.value ? user.travelDistance.value * 1609.34 : 25 * 1609.34}&key=${env.googleAPIKey}"));

      if (response.statusCode == 200) {
        var jsonList = json.decode(utf8.decode(response.bodyBytes).toString());
        List googleLounges =
            (jsonList['results'] != null ? jsonList['results'] : []);

        return ["200", googleLounges];
      } else {
        return ["400", "Occurred an error, Please try again"];
      }
    } catch (e) {
      return ["500", "Occurred an error, Please try again"];
    }
  }

  static Future getGoogleImage(photoId) async {
    try {
      String url =
          "https://maps.googleapis.com/maps/api/place/photo?photo_reference=$photoId&maxwidth=100&key=${env.googleAPIKey}";
      // final response = await http.get(Uri.parse(url));

      // if (response.statusCode == 200) {
      return Image.network(url);
      // }
    } catch (e) {
      return ["500", "Occurred an error, Please try again"];
    }
  }

  static Future getRecomendations(args) async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://func-thecigarkey-dev.azurewebsites.net/api/GetProfileRecommendation"),
          body: json.encode(args));

      if (response.statusCode == 200) {
        var jsonList = json.decode(utf8.decode(response.bodyBytes).toString());
        List recomendations = jsonList["Products"];

        return ["200", recomendations];
      } else {
        return ["400", "Occurred an error, Please try again"];
      }
    } catch (e) {
      return ["500", "Occurred an error, Please try again"];
    }
  }

  static Future getWeeklyRecomendations(args) async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://func-thecigarkey-dev.azurewebsites.net/api/GetRecommendationOfTheWeek"),
          body: json.encode(args));

      if (response.statusCode == 200) {
        var jsonList = json.decode(utf8.decode(response.bodyBytes).toString());
        List recomendations =
            jsonList["Products"] != null ? jsonList["Products"] : [];

        return ["200", recomendations];
      } else {
        return ["400", "Occurred an error, Please try again"];
      }
    } catch (e) {
      return ["500", "Occurred an error, Please try again"];
    }
  }
}
