import 'package:cigarKey/model/ProfileModel.dart';
import 'package:cigarKey/utils/userPreferences.dart';
import 'package:get/get.dart';

Profile userInfo = new Profile();

class UserController extends GetxController {
  final name = userInfo.FirstName.obs;
  final lastName = userInfo.LastName.obs;
  final phone = userInfo.PhoneNumber.obs;
  final image = userInfo.ProfileImagePath.obs;
  final zip = userInfo.ZipCode.obs;
  final email = userInfo.Email.obs;
  final gender = userInfo.Email.obs;
  final tutorialTaken = userInfo.TutorialTaken.obs;
  final notification = userInfo.notification.obs;
  final travelActive = userInfo.travelActive.obs;
  final travelDistance = userInfo.travelDistance.obs;
  final rank = userInfo.rank.obs;

  void setName(String nameValue) => name.value = nameValue;
  void setEmail(String emailValue) => email.value = emailValue;
  void setImage(String tokenValue) => image.value = tokenValue;
  void setZip(String zipValue) => zip.value = zipValue;
  void setLastName(String last) => lastName.value = last;
  void setPhone(String phonevalue) => phone.value = phonevalue;
  void setGender(String gendervalue) => gender.value = gendervalue;
  void setTutorialTaken(bool tutorialValue) =>
      tutorialTaken.value = tutorialValue;
  void setNotification(bool notifiValue) => notification.value = notifiValue;
  void setTravelActive(bool travelActiveValue) =>
      travelActive.value = travelActiveValue;
  void setTravelDistance(int travelDistanceValue) =>
      travelDistance.value = travelDistanceValue;
  void setRank(String rankValue) => rank.value = rankValue;

  void deleteInfo() {
    name.value = '';
    email.value = '';
    image.value = '';
    zip.value = '';
    lastName.value = '';
    rank.value = '';
    phone.value = '';
    gender.value = '';
    tutorialTaken.value = false;
    notification.value = false;
    travelActive.value = false;
    travelDistance.value = 0;
    UserPreferences().cleanUser();
  }
}
