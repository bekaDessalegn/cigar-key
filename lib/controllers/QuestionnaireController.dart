import 'package:cigarKey/model/QuestionnaireModel.dart';
import 'package:get/get.dart';

Questionnaire questionnaireInfo = new Questionnaire();

class QuestionnaireController extends GetxController {
  final preferenceId = questionnaireInfo.preferenceId.obs;
  final type = questionnaireInfo.type.obs;
  final name = questionnaireInfo.name.obs;
  final rank = questionnaireInfo.rank.obs;

  void setPreferenceId(String idValue) => preferenceId.value = idValue;
  void setType(String typeValue) => type.value = typeValue;
  void setName(String nameValue) => name.value = nameValue;
  void setRank(int rankValue) => rank.value = rankValue;

  void deleteInfo() {
    preferenceId.value = '';
    type.value = '';
    name.value = '';
    rank.value = 0;
  }
}
