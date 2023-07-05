import 'dart:convert';

Questionnaire questionnaireFromJson(String str) =>
    questionnaireFromJson(json.decode(str));

class Questionnaire {
  Questionnaire({
    //  this.ETag = {},
    this.preferenceId = "",
    this.type = "",
    this.name = "",
    this.rank = 0,
  });

  String preferenceId;
  String type;
  String name;
  int rank;

  factory Questionnaire.fromJson(List<dynamic> json) => Questionnaire(
      // preferenceId: json["PreferenceId"],
      // type: json["Type"],
      // name: json["Name"],
      // rank: json["Rank"],
      );

  // List<dynamic> toJson() => {
  // "PreferenceId": preferenceId,
  // "Type": type,
  // "Name": name,
  // "Rank": rank,
  // };
}
