import 'package:cigarKey/controllers/userController.dart';
import 'package:cigarKey/service/ApiService.dart';
import 'package:cigarKey/utils/fontSize.dart';
import 'package:cigarKey/widgets/ErrorPopup.dart';
import 'package:cigarKey/widgets/GeneralHeader.dart';
import 'package:flutter/material.dart';
import 'package:geofence_service/geofence_service.dart';
import 'package:get/get.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

UserController user = Get.put(UserController());

class _SettingsState extends State<Settings> {
  final _geofenceService = GeofenceService.instance;
  var notification = user.notification.value;
  var active = user.travelActive.value;
  var distance = user.travelDistance.value;

  Future updateNotification(value) async {
    var userData = {
      "Email": user.email.value,
      "Config": {
        "Notifications": value,
        "TravelMode": {
          "Active": user.travelActive.value,
          "Distance": user.travelDistance.value
        }
      }
    };
    await ApiService.updateProfile(userData).then((response) => {
          if (response[0] != "200")
            {ErrorPopUp.errorPopUp(context, "${response[1]}")}
          else
            {
              setState(
                () {
                  notification = user.notification.value;
                },
              ),
              if (user.notification.value)
                {_geofenceService.start()}
              else
                {_geofenceService.stop()}
            }
        });
  }

  Future updateActive(value) async {
    var userData = {
      "Email": user.email.value,
      "Config": {
        "Notification": user.notification.value,
        "TravelMode": {"Active": value, "Distance": user.travelDistance.value}
      }
    };
    await ApiService.updateProfile(userData).then((value) => {
          if (value[0] != "200")
            {ErrorPopUp.errorPopUp(context, "${value[1]}")}
          else
            {
              setState(
                () {
                  active = user.travelActive.value;
                },
              ),
            }
        });
  }

  Future updateDistance(value) async {
    var userData = {
      "Email": user.email.value,
      "Config": {
        "Notification": user.notification.value,
        "TravelMode": {"Active": user.travelActive.value, "Distance": value}
      }
    };
    await ApiService.updateProfile(userData).then((value) => {
          if (value[0] != "200" && mounted)
            {ErrorPopUp.errorPopUp(context, "${value[1]}")}
          else
            {
              setState(
                () {
                  distance = user.travelDistance.value;
                },
              ),
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;

    ButtonStyle buttonStyle = new ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        backgroundColor:
            MaterialStateProperty.all<Color>(Color.fromRGBO(197, 169, 1, 1)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white));

    ButtonStyle buttonUnactivateStyle = new ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
              style: BorderStyle.solid,
              width: 1,
              color: Color.fromRGBO(197, 169, 1, 1)),
        )),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.grey));

    return (Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Wrap(
          children: [
            Container(
              child: GeneralHeader(heightSize, "Settings"),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: heightSize * .8,
                width: widthSize,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(bottom: heightSize * .05)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: heightSize * .02,
                            horizontal: widthSize * .05),
                        child: SwitchListTile(
                          value: notification,
                          title: Text(
                            'Notifications',
                            textScaleFactor: Fonts().textSmall(context),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: heightSize * .03),
                          ),
                          subtitle: Text(
                            'Users will receive push notifications within 10 miles of any participating lounge',
                            textScaleFactor: Fonts().textverySmall(context),
                            style: TextStyle(
                                color: Colors.grey, fontSize: heightSize * .02),
                          ),
                          onChanged: (value) {
                            updateNotification(value);
                          },
                          activeColor: Colors.white,
                          inactiveTrackColor: Colors.grey.shade800,
                          activeTrackColor: Color.fromRGBO(197, 169, 1, 1),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: heightSize * .02,
                            horizontal: widthSize * .05),
                        child: SwitchListTile(
                          value: active,
                          title: Text(
                            'Travel Mode',
                            textScaleFactor: Fonts().textSmall(context),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: heightSize * .03),
                          ),
                          subtitle: Text(
                            'you will receive push notifications away from the zip code area.',
                            textScaleFactor: Fonts().textverySmall(context),
                            style: TextStyle(
                                color: Colors.grey, fontSize: heightSize * .02),
                          ),
                          onChanged: (value) {
                            updateActive(value);
                          },
                          activeColor: Colors.white,
                          inactiveTrackColor: Colors.grey.shade800,
                          activeTrackColor: Color.fromRGBO(197, 169, 1, 1),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: widthSize * .05,
                              vertical: heightSize * .02),
                          child: active
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: widthSize * .28,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          updateDistance(30);
                                        },
                                        child: Text('30 miles',
                                            textScaleFactor:
                                                Fonts().textverySmall(context),
                                            style: TextStyle(
                                                fontSize: heightSize * .02)),
                                        style: distance == 30
                                            ? buttonStyle
                                            : buttonUnactivateStyle,
                                      ),
                                    ),
                                    Container(
                                      width: widthSize * .28,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            updateDistance(50);
                                          });
                                        },
                                        child: Text('50 miles',
                                            textScaleFactor:
                                                Fonts().textverySmall(context),
                                            style: TextStyle(
                                                fontSize: heightSize * .02)),
                                        style: distance == 50
                                            ? buttonStyle
                                            : buttonUnactivateStyle,
                                      ),
                                    ),
                                    Container(
                                      width: widthSize * .28,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            updateDistance(100);
                                          });
                                        },
                                        child: Text('100 miles',
                                            textScaleFactor:
                                                Fonts().textverySmall(context),
                                            style: TextStyle(
                                                fontSize: heightSize * .02)),
                                        style: distance == 100
                                            ? buttonStyle
                                            : buttonUnactivateStyle,
                                      ),
                                    ),
                                  ],
                                )
                              : null)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
