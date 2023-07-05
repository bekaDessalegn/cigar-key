import 'package:cigarKey/controllers/userController.dart';
import 'package:cigarKey/presentation/custom__icons_icons.dart';
import 'package:cigarKey/service/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:cigarKey/utils/fontSize.dart';
import 'package:get/get.dart';

class TutorialPage {
  static tutorialPopUp(BuildContext context) {
    UserController user = Get.put(UserController());

    TextStyle mainTextStyle = TextStyle(
      color: Color.fromRGBO(197, 169, 1, 1),
      fontFamily: 'Title',
    );
    TextStyle buttonsTextStyle = TextStyle(
        color: Color.fromRGBO(197, 169, 1, 1),
        fontFamily: 'Title',
        decoration: TextDecoration.underline,
        decorationStyle: TextDecorationStyle.solid);
    TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontFamily: 'Title',
    );

    Future.delayed(Duration.zero, () {
      showDialog(
          useSafeArea: false,
          context: context,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height * .8,
              color: Colors.black.withOpacity(.8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    height: MediaQuery.of(context).size.height * .8,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .02,
                              bottom: MediaQuery.of(context).size.height * .02),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Hi, ${user.name.value}',
                            textScaleFactor: Fonts().text(context),
                            style: mainTextStyle,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * .03,
                          ),
                          child: Text(
                            'You want to start the welcome tour',
                            textScaleFactor: Fonts().text(context),
                            style: textStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.height * .02),
                            child: Image(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                width: MediaQuery.of(context).size.width * 0.5,
                                image: AssetImage('assets/logoBlanco.png'))),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              if (!user.tutorialTaken.value) {
                                var args = {
                                  "Email": '${user.email.value}',
                                  "TutorialTaken": true,
                                };
                                ApiService.updateProfile(args);
                              }
                              Navigator.of(context).pop();
                            },
                            child: Text('skip',
                                textScaleFactor: Fonts().text(context),
                                style: buttonsTextStyle)),
                        TextButton(
                            onPressed: () {
                              // Future.delayed(Duration.zero, () {
                              Navigator.of(context).pop();
                              tourWeekly(context);
                              // });
                            },
                            child: Text('start',
                                textScaleFactor: Fonts().text(context),
                                style: buttonsTextStyle))
                      ],
                    ),
                  )
                ],
              ),
            );
          });
    });
  }

  static tourMenu(BuildContext context) {
    TextStyle mainTextStyle = TextStyle(
      color: Color(0xffffffff),
    );
    return showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).pop();
                tourLocation(context);
              },
              child: Container(
                height: MediaQuery.of(context).size.height * .5,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .9,
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Icon(
                              CustomIcons.arrow_1,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              width: MediaQuery.of(context).size.width * .7,
                              height: MediaQuery.of(context).size.height * .05,
                              child: Container(
                                color: Colors.black.withOpacity(.8),
                                child: Text(
                                  'Home',
                                  maxLines: 3,
                                  textScaleFactor: Fonts().text(context),
                                  style: mainTextStyle,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static tourWeekly(BuildContext context) {
    TextStyle mainTextStyle = TextStyle(
      color: Color(0xffffffff),
    );
    return showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).pop();
                tourEvents(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .3,
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * .05,
                            child: Icon(
                              CustomIcons.arrow_1,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                          Align(
                            child: Container(
                              width: MediaQuery.of(context).size.width * .7,
                              height: MediaQuery.of(context).size.height * .05,
                              color: Colors.black.withOpacity(.8),
                              child: Container(
                                color: Colors.black.withOpacity(.8),
                                child: Text(
                                  'Featured Product of the Week, Tailored to your preferences',
                                  maxLines: 3,
                                  textScaleFactor: Fonts().text(context),
                                  style: mainTextStyle,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static tourEvents(BuildContext context) {
    TextStyle mainTextStyle = TextStyle(
      color: Color(0xffffffff),
    );
    return showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).pop();
                tourMenu(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .67,
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * .05,
                            child: Icon(
                              CustomIcons.arrow_1,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .7,
                            height: MediaQuery.of(context).size.height * .05,
                            child: Container(
                              color: Colors.black.withOpacity(.8),
                              child: Text(
                                'Featured Lounges/Events Near You',
                                maxLines: 3,
                                textScaleFactor: Fonts().text(context),
                                style: mainTextStyle,
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static tourLocation(BuildContext context) {
    TextStyle mainTextStyle = TextStyle(
      color: Color(0xffffffff),
    );
    return showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              // splashColor: Colors.transparent,
              // hoverColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).pop();
                tourScan(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .9,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .2),
                      height: MediaQuery.of(context).size.height * .9,
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Icon(
                              CustomIcons.arrow_1,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              width: MediaQuery.of(context).size.width * .5,
                              height: MediaQuery.of(context).size.height * .05,
                              child: Container(
                                color: Colors.black.withOpacity(.8),
                                child: Text(
                                  'Find Locations',
                                  maxLines: 3,
                                  textScaleFactor: Fonts().text(context),
                                  style: mainTextStyle,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static tourScan(BuildContext context) {
    TextStyle mainTextStyle = TextStyle(
      color: Color(0xffffffff),
    );
    return showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).pop();
                tourFavorite(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .9,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * .3),
                      height: MediaQuery.of(context).size.height * .9,
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * .05,
                                  bottom: MediaQuery.of(context).size.height *
                                      .025),
                              child: Container(
                                alignment: Alignment.topRight,
                                width: MediaQuery.of(context).size.width * .5,
                                height:
                                    MediaQuery.of(context).size.height * .15,
                                child: Container(
                                  color: Colors.black.withOpacity(.8),
                                  child: Text(
                                    'Scan Cigar Key QR Code for product description and user preference rating',
                                    maxLines: 6,
                                    textScaleFactor: Fonts().text(context),
                                    style: mainTextStyle,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .1,
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              CustomIcons.arrow_2,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static tourFavorite(BuildContext context) {
    TextStyle mainTextStyle = TextStyle(
      color: Color(0xffffffff),
    );
    return showDialog(
        context: context,
        builder: (context) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).pop();
                tourProfile(context);
              },
              child: SafeArea(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .9,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .2),
                      height: MediaQuery.of(context).size.height * .87,
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: MediaQuery.of(context).size.width * .5,
                              height: MediaQuery.of(context).size.height * .20,
                              child: Container(
                                color: Colors.black.withOpacity(.8),
                                child: Text(
                                  'Your Locker - View suggested products based on your profile results and store products here by by clicking the heart icon on the product description',
                                  // maxLines: 50,
                                  textScaleFactor: Fonts().text(context),
                                  style: mainTextStyle,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .1,
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              CustomIcons.arrow_2,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ),
          );
        });
  }

  static tourProfile(BuildContext context) {
    UserController user = Get.put(UserController());
    TextStyle mainTextStyle = TextStyle(
      color: Color(0xffffffff),
    );
    return showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                if (!user.tutorialTaken.value) {
                  var args = {
                    "Email": '${user.email.value}',
                    "TutorialTaken": true,
                  };
                  ApiService.updateProfile(args);
                }
                Navigator.of(context).pop();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .9,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .4),
                      height: MediaQuery.of(context).size.height * .9,
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: MediaQuery.of(context).size.width * .5,
                              height: MediaQuery.of(context).size.height * .05,
                              child: Container(
                                color: Colors.black.withOpacity(.8),
                                child: Text(
                                  'View/Edit Profile',
                                  maxLines: 3,
                                  textScaleFactor: Fonts().text(context),
                                  style: mainTextStyle,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .1,
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              CustomIcons.arrow_2,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
