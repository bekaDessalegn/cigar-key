import 'package:cigarKey/controllers/userController.dart';
import 'package:cigarKey/presentation/custom__icons_icons.dart';
import 'package:cigarKey/service/ApiService.dart';
import 'package:cigarKey/utils/b2cClient.dart';
import 'package:cigarKey/utils/fontSize.dart';
import 'package:cigarKey/widgets/ErrorPopup.dart';
import 'package:cigarKey/widgets/TutorialPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../providers/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage(this.tabController);
  final tabController;
  // const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState(tabController);
}

class _ProfilePageState extends State<ProfilePage> {
  UserController user = Get.put(UserController());
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
  }

  final TabController tabController;
  _ProfilePageState(this.tabController);
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    // var b2cClient = B2CAuth(context, _btnController);
    final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;
    Color colorText = Color.fromRGBO(197, 169, 1, 1);
    ButtonStyle buttonStyleError = new ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
        backgroundColor: MaterialStateProperty.all<Color>(colorText));
    ButtonStyle buttonStyleNo = new ButtonStyle(
        shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
        side: MaterialStateProperty.all(BorderSide(color: colorText)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent));
    ButtonStyle buttonStyleRedonde = new ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
        backgroundColor: MaterialStateProperty.all<Color>(colorText));

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.black,
        width: widthSize,
        child: Padding(
          padding: EdgeInsets.only(
              // left: widthSize * .05,
              // right: widthSize * .05,
              top: heightSize * .035,
              bottom: heightSize * .08),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  'Profile',
                  textScaleFactor: Fonts().textTitle(context),
                  style: TextStyle(
                    fontFamily: 'Title',
                    color: Colors.white,
                    // fontSize: heightSize * .03
                  ),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: heightSize * .05),
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          backgroundImage: NetworkImage(user
                                      .image.value.length !=
                                  0
                              ? user.image.value
                              : 'https://cdn5.vectorstock.com/i/thumb-large/45/59/profile-photo-placeholder-icon-design-in-gray-vector-37114559.jpg'),

                          //  AssetImage('assets/profilePhoto.png'),
                          radius: widthSize * .2,
                        ),
                      ),
                      Text(
                          user.name.value.length != 0
                              ? '${user.name.value} ${user.lastName.value}'
                              : ' ',
                          textScaleFactor: Fonts().textTitle(context),
                          // 'Ian Pulido',
                          style: TextStyle(
                            color: Colors.white,
                            // fontSize: heightSize * .03,
                            fontFamily: 'Text',
                          )),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: heightSize * .02),
                        child: ElevatedButton(
                            onPressed: () async {
                              Map args = {
                                "FirstName": user.name.value,
                                "LastName": user.lastName.value,
                                "Email": user.email.value,
                                "PhoneNumber": user.phone.value,
                                "ZipCode": user.zip.value,
                                "ProfileImagePath": user.image.value,
                              };
                              Navigator.pushNamed(context, '/EditProfile',
                                  arguments: args);
                            },
                            style: buttonStyleRedonde,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: heightSize * .015,
                                  horizontal: widthSize * .06),
                              child: Text(
                                "Edit Profile",
                                textScaleFactor: Fonts().text(context),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Text',
                                ),
                              ),
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.pushNamed(context, '/FavoritesPage');
                          tabController.animateTo(3);
                        },
                        child: ListTile(
                          title: Text(
                            'My Locker',
                            textScaleFactor: Fonts().text(context),
                            style: TextStyle(
                                // fontSize: heightSize * .02,
                                color: Colors.white,
                                fontFamily: 'Text'),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              // Navigator.pushNamed(context, '/FavoritesPage');
                              tabController.animateTo(3);
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: Color.fromRGBO(156, 27, 23, 1),
                              size: heightSize * .05,
                            ),
                          ),
                          leading: Icon(
                            CustomIcons.favorites,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/Products');
                        },
                        child: ListTile(
                          title: Text(
                            'All Products',
                            textScaleFactor: Fonts().text(context),
                            style: TextStyle(
                                // fontSize: heightSize * .02,
                                color: Colors.white,
                                fontFamily: 'Text'),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/Products');
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: Color.fromRGBO(156, 27, 23, 1),
                              size: heightSize * .05,
                            ),
                          ),
                          leading: Icon(
                            CustomIcons.rewards,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/SuggestionsPage');
                        },
                        child: ListTile(
                          title: Text(
                            'Your Suggestions',
                            textScaleFactor: Fonts().text(context),
                            style: TextStyle(
                                // fontSize: heightSize * .02,
                                color: Colors.white,
                                fontFamily: 'Text'),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/SuggestionsPage');
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: Color.fromRGBO(156, 27, 23, 1),
                              size: heightSize * .05,
                            ),
                          ),
                          leading: Icon(
                            CustomIcons.suggestions,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          tabController.animateTo(0);
                          TutorialPage.tutorialPopUp(context);
                        },
                        child: ListTile(
                          title: Text(
                            'Tutorial',
                            textScaleFactor: Fonts().text(context),
                            style: TextStyle(
                                // fontSize: heightSize * .02,
                                color: Colors.white,
                                fontFamily: 'Text'),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              tabController.animateTo(0);
                              TutorialPage.tutorialPopUp(context);
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: Color.fromRGBO(156, 27, 23, 1),
                              size: heightSize * .05,
                            ),
                          ),
                          leading: Image.asset(
                            "assets/Education.png",
                            scale: 4,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/StartTest');
                          provider.back = true;
                        },
                        child: ListTile(
                          title: Text(
                            'Questionnaire',
                            textScaleFactor: Fonts().text(context),
                            style: TextStyle(
                                // fontSize: heightSize * .02,
                                color: Colors.white,
                                fontFamily: 'Text'),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/StartTest');
                              provider.back = true;
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: Color.fromRGBO(156, 27, 23, 1),
                              size: heightSize * .05,
                            ),
                          ),
                          leading: Icon(
                            CustomIcons.questionnaire,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: heightSize * .02),
                        child: Divider(
                          height: 1,
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/Settings');
                        },
                        child: ListTile(
                          title: Text(
                            'Settings',
                            textScaleFactor: Fonts().text(context),
                            style: TextStyle(
                                // fontSize: heightSize * .02,
                                color: Colors.white,
                                fontFamily: 'Text'),
                          ),
                          leading: Icon(
                            CustomIcons.settings,
                            color: Colors.white,
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/Settings');
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_right,
                                color: Color.fromRGBO(156, 27, 23, 1),
                                size: heightSize * .05,
                              )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, StateSetter setState) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    backgroundColor:
                                        Color.fromRGBO(34, 30, 31, 1),
                                    content: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.27,
                                      // width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Icon(
                                                Icons.close_outlined,
                                                color: Colors.white,
                                                size: heightSize * .03,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                bottom: heightSize * .02,
                                              ),
                                              child: Icon(
                                                Icons.headset_mic_outlined,
                                                color: Color.fromRGBO(
                                                    197, 169, 1, 1),
                                                size: heightSize * .05,
                                              )),
                                          Text(
                                            'Phone Number',
                                            textScaleFactor:
                                                Fonts().textSmall(context),
                                            style: TextStyle(
                                              fontFamily: "Text",
                                              color: Colors.white,
                                              // fontSize: heightSize * .02,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            '55 1234 5678',
                                            textScaleFactor:
                                                Fonts().textverySmall(context),
                                            style: TextStyle(
                                              fontFamily: "Text",
                                              color: Colors.white,
                                              // fontSize: heightSize * .02,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: heightSize * .02),
                                            child: Text(
                                              'Email',
                                              textScaleFactor:
                                                  Fonts().textSmall(context),
                                              style: TextStyle(
                                                fontFamily: "Text",
                                                color: Colors.white,
                                                // fontSize: heightSize * .02,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Text(
                                            'email@example.com',
                                            textScaleFactor:
                                                Fonts().textverySmall(context),
                                            style: TextStyle(
                                              fontFamily: "Text",
                                              color: Colors.white,
                                              // fontSize: heightSize * .02,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              });
                        },
                        child: ListTile(
                          title: Text(
                            'Contact Us',
                            textScaleFactor: Fonts().text(context),
                            style: TextStyle(
                                // fontSize: heightSize * .02,
                                color: Colors.white,
                                fontFamily: 'Text'),
                          ),
                          leading:
                              Icon(CustomIcons.contactUs, color: Colors.white),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, StateSetter setState) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    backgroundColor:
                                        Color.fromRGBO(34, 30, 31, 1),
                                    title: Icon(
                                      Icons.warning,
                                      size: MediaQuery.of(context).size.width >
                                              450
                                          ? MediaQuery.of(context).size.width >
                                                  700
                                              ? 80
                                              : 60
                                          : MediaQuery.of(context).size.width >
                                                  390
                                              ? 50
                                              : 40,
                                      color: colorText,
                                    ),
                                    content: Text(
                                      "Are you sure you want to log out?",
                                      textScaleFactor: Fonts().text(context),
                                      style: TextStyle(
                                        fontFamily: "Text",
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.width >
                                                    450
                                                ? MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        700
                                                    ? 40
                                                    : 19
                                                : 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 5,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                                style: buttonStyleError,
                                                onPressed: () async {
                                                  Navigator
                                                      .pushNamedAndRemoveUntil(
                                                    context,
                                                    '/LoginPage',
                                                    (Route<dynamic> route) =>
                                                        false,
                                                  );
                                                  // b2cClient
                                                  //     .logout()
                                                  //     .then((value) => {
                                                  //           if (value == "200")
                                                  //             {
                                                  //               Navigator
                                                  //                   .pushNamedAndRemoveUntil(
                                                  //                 context,
                                                  //                 '/LoginPage',
                                                  //                 (Route<dynamic>
                                                  //                         route) =>
                                                  //                     false,
                                                  //               )
                                                  //             }
                                                  //           else
                                                  //             {
                                                  //               ErrorPopUp
                                                  //                   .errorPopUp(
                                                  //                       context,
                                                  //                       "Occurred an error try again")
                                                  //             }
                                                  //         });
                                                },
                                                child: Text(
                                                  "Yes",
                                                  textScaleFactor: Fonts()
                                                      .textButton(context),
                                                  style: TextStyle(
                                                    fontFamily: "Bold",
                                                    color: Colors.white,
                                                    // fontSize: MediaQuery.of(
                                                    //                 context)
                                                    //             .size
                                                    //             .width >
                                                    //         450
                                                    //     ? MediaQuery.of(context)
                                                    //                 .size
                                                    //                 .width >
                                                    //             700
                                                    //         ? 35
                                                    //         : 20
                                                    //     : 16,
                                                  ),
                                                )),
                                            ElevatedButton(
                                                style: buttonStyleNo,
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  "No",
                                                  textScaleFactor: Fonts()
                                                      .textButton(context),
                                                  style: TextStyle(
                                                    fontFamily: "Bold",
                                                    color: Colors.white,
                                                    // fontSize: MediaQuery.of(
                                                    //                 context)
                                                    //             .size
                                                    //             .width >
                                                    //         450
                                                    //     ? MediaQuery.of(context)
                                                    //                 .size
                                                    //                 .width >
                                                    //             700
                                                    //         ? 35
                                                    //         : 20
                                                    //     : 16,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                });
                              });
                        },
                        child: ListTile(
                          title: Text(
                            'Log Out',
                            textScaleFactor: Fonts().text(context),
                            style: TextStyle(
                                // fontSize: heightSize * .02,
                                color: Colors.white,
                                fontFamily: 'Text'),
                          ),
                          leading:
                              Icon(CustomIcons.logout, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
