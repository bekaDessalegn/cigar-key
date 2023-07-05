import 'package:cigarKey/controllers/userController.dart';
import 'package:cigarKey/presentation/custom__icons_icons.dart';
import 'package:cigarKey/service/ApiService.dart';
import 'package:cigarKey/utils/fontSize.dart';
import 'package:cigarKey/widgets/ErrorPopup.dart';
import 'package:cigarKey/widgets/TutorialPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blur/blur.dart';

class MenuPage extends StatelessWidget {
  final TabController tabController;
  MenuPage(this.tabController);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MenuPageBody(tabController),
    );
  }
}

class MenuPageBody extends StatefulWidget {
  final TabController tabController;
  MenuPageBody(this.tabController);
  @override
  State<MenuPageBody> createState() => _MenuPageBodyState(tabController);
}

class _MenuPageBodyState extends State<MenuPageBody> {
  UserController user = Get.put(UserController());
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List weekly = [];
  List _listFavorites = [];
  List _list = [];
  bool done = false;

  getWeekly() async {
    var args = {"Email": user.email.value};
    ApiService.getWeeklyRecomendations(args).then((value) => {
          if (value[0] == "200")
            {
              setState(() {
                weekly = value[1];
                done = true;
              })
            }
        });
  }

  getFavorites() async {
    ApiService.getFavorites(user.email.value).then(((favorites) => {
          if (favorites[0] == '200')
            {
              if (mounted)
                {
                  setState(() {
                    _listFavorites = favorites[1];
                  }),
                }
            }
          else if (favorites[0] == "400")
            {
              ErrorPopUp.errorPopUp(context, favorites[1]),
            }
          else
            {
              ErrorPopUp.errorPopUp(context, favorites[1]),
            }
        }));
  }

  @override
  void initState() {
    getWeekly();
    getFavorites();
    super.initState();
  }

  final TabController tabController;
  _MenuPageBodyState(this.tabController);

  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;

    bool isfavorite = false;

    Color gold = Color.fromRGBO(201, 151, 23, 1);
    Color colorBox = Color.fromRGBO(18, 16, 16, 0.7);
    double userIconSize = MediaQuery.of(context).size.width > 450 ? 80.0 : 65.0;
    double userContainerSize =
        MediaQuery.of(context).size.width > 450 ? 200.0 : 180.0;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.black,
        drawer: Drawer(
          backgroundColor: Color.lerp(Colors.black, Colors.grey.shade800, 0.65),
          child: ListView(
            children: [
              // Container(
              //   // color: Colors.amber.withOpacity(.3),
              //   height: heightSize > 600 ? heightSize * .075 : heightSize * .065,
              //   child: DrawerHeader(
              //       // decoration: BoxDecoration(color: Colors.grey.shade800),
              //       padding: EdgeInsets.only(left: widthSize * .03),
              //       child: InkWell(
              //         onTap: () {
              //           tabController.animateTo(4);
              //         },

              //         child: Row(
              //           children: [
              //             Container(
              //               height: heightSize * .06,
              //               // color: Colors.red.withOpacity(.3),
              //               padding: EdgeInsets.only(left: widthSize * .01),
              //               alignment: Alignment.topCenter,
              //               child: CircleAvatar(
              //                 backgroundColor: Colors.black,
              //                 backgroundImage: NetworkImage(user
              //                             .image.value.length !=
              //                         0
              //                     ? user.image.value
              //                     : 'https://cdn5.vectorstock.com/i/thumb-large/45/59/profile-photo-placeholder-icon-design-in-gray-vector-37114559.jpg'),
              //                 radius: widthSize > 600
              //                     ? widthSize * .03
              //                     : widthSize * .06,
              //               ),
              //             ),
              //             Container(
              //               width: userContainerSize,
              //               height: heightSize * .1,
              //               alignment: Alignment.centerLeft,
              //               child: Padding(
              //                 padding: EdgeInsets.symmetric(
              //                   horizontal: widthSize * .01,
              //                 ),
              //                 child: Text(
              //                   '${user.name.value} ${user.lastName.value}',
              //                   textScaleFactor: Fonts().text(context),
              //                   overflow: TextOverflow.ellipsis,
              //                   maxLines: 3,
              //                   softWrap: false,
              //                   style: TextStyle(
              //                     fontFamily: "Title",
              //                     color: Colors.white,
              //                   ),
              //                   textAlign: TextAlign.left,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),

              //       )),
              // ),
              Divider(
                color: Colors.white,
                indent: widthSize * .05,
                endIndent: widthSize * .05,
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/AboutUs');
                },
                leading: Image.asset(
                  'assets/about.png',
                  scale: widthSize > 600 ? 1.0 : 1.5,
                ),
                title: Text(
                  'About Us',
                  textScaleFactor: Fonts().text(context),
                  style: TextStyle(color: Colors.white, fontFamily: 'Text'),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/AppFeatures');
                },
                leading: Image.asset(
                  'assets/faq.png',
                  scale: widthSize > 600 ? 1.0 : 1.5,
                ),
                title: Text(
                  'Cigar FAQ',
                  textScaleFactor: Fonts().text(context),
                  style: TextStyle(color: Colors.white, fontFamily: 'Text'),
                ),
              ),
            ],
          ),
        ),
        body: Stack(children: [
          Container(
            child: user.tutorialTaken.value
                ? Container()
                : TutorialPage.tutorialPopUp(context),
          ),
          Container(
            width: widthSize,
            height: heightSize,
            color: Colors.black,
          ),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: heightSize * .22,
                child: Align(
                  child: Stack(
                    children: [
                      Image.asset(
                        widthSize > 600
                            ? 'assets/largeLabel.png'
                            : 'assets/label.png',
                        width: widthSize,
                        fit: BoxFit.fill,
                        //scale: widthSize > 600 ? 1 : 4,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/logoBlanco.png',
                          scale: widthSize > 600 ? 18.0 : 25.0,
                        ),
                      ),
                      Container(
                          child: Column(
                        children: [
                          Padding(padding: EdgeInsets.all(heightSize * .03)),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: heightSize * .02),
                                    child: InkWell(
                                      onTap: () {
                                        _scaffoldKey.currentState?.openDrawer();
                                      },
                                      child: Icon(
                                        Icons.menu,
                                        color: Colors.white,
                                        size: widthSize > 600
                                            ? widthSize * .05
                                            : widthSize * .1,
                                      ),
                                    )

                                    // IconButton(
                                    //   onPressed: () {
                                    //     _scaffoldKey.currentState?.openDrawer();
                                    //   },
                                    //   icon: Icon(
                                    //     Icons.menu,
                                    //     color: Colors.white,
                                    //     size: widthSize * .1,
                                    //   ),
                                    // ),
                                    ),
                                InkWell(
                                  onTap: () {
                                    tabController.animateTo(4);
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${user.name.value} ${user.lastName.value}',
                                                  textScaleFactor: Fonts()
                                                      .textSmall(context),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                    fontFamily: "Text",
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Text(
                                                  'Cigar Key Preference: ${user.rank.value}',
                                                  textScaleFactor: Fonts()
                                                      .preferenceMenu(context),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                    fontFamily: "Text",
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: widthSize * .02),
                                              child: CircleAvatar(
                                                backgroundColor: Colors.black,
                                                backgroundImage: NetworkImage(user
                                                            .image
                                                            .value
                                                            .length !=
                                                        0
                                                    ? user.image.value
                                                    : 'https://cdn5.vectorstock.com/i/thumb-large/45/59/profile-photo-placeholder-icon-design-in-gray-vector-37114559.jpg'),
                                                radius: widthSize > 700
                                                    ? widthSize * .02
                                                    : widthSize * .05,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: heightSize * .01)),
              done
                  ? Container(
                      height: heightSize * .7,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Divider(
                                  thickness: 1,
                                  color: Colors.white,
                                  indent: widthSize * .05,
                                  endIndent: widthSize * .85,
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.white,
                                  indent: widthSize * .85,
                                  endIndent: widthSize * .05,
                                ),
                                Center(
                                  child: Container(
                                    color: Colors.black,
                                    child: Text(
                                      'Weekly Spotlight',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Title'),
                                      textScaleFactor: Fonts().text(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: widthSize * .05,
                                  vertical: heightSize * .02,
                                ),
                                child: weekly.length != 0
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            isfavorite = _listFavorites.any(
                                                (element) =>
                                                    element.Number ==
                                                    weekly[0]["Number"]);
                                          });

                                          Map args = {
                                            "Number": weekly[0]["Number"],
                                            "Brand": weekly[0]["Brand"],
                                            "Name": weekly[0]["Name"],
                                            "Image": weekly[0]["Image"],
                                            "Description": weekly[0]
                                                ["Description"],
                                            "rate": weekly[0]["Rank"],
                                            "favorite": isfavorite,
                                            "Shape": weekly[0]["Shape"],
                                            "Color": weekly[0]["Color"],
                                            "Country": weekly[0]["Country"],
                                            "Flavor": weekly[0]["Flavor"],
                                            "Size": weekly[0]["Size"],
                                            "CountryFlag": weekly[0]
                                                ["CountryFlag"],
                                            "flag": true,
                                            "products": true,
                                          };
                                          Navigator.pushNamed(
                                              context, "/DetailsPage",
                                              arguments: args);
                                        },
                                        child: Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: heightSize * .04),
                                                child: Container(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                32)),
                                                    child: Image.network(
                                                      "${weekly[0]["Image"]}",
                                                      height: heightSize * .32,
                                                      width: widthSize,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Container(
                                                    width: widthSize,
                                                    // height: heightSize * .15,
                                                    decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            79, 47, 14, 0.98),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15))),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Container(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 15,
                                                                        left:
                                                                            20),
                                                                child: Text(
                                                                  'Cigar of the week',
                                                                  textScaleFactor:
                                                                      Fonts().text(
                                                                          context),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: TextStyle(
                                                                      fontFamily: 'Title',
                                                                      overflow: TextOverflow.ellipsis,
                                                                      // fontSize: heightSize * .028,
                                                                      color: Colors.white),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 2,
                                                                        left:
                                                                            20),
                                                                child: Text(
                                                                  weekly.length !=
                                                                          0
                                                                      ? "${weekly[0]["Brand"]}, ${weekly[0]["Name"]}"
                                                                      : 'Oliva, Serie V Melanio',
                                                                  textScaleFactor:
                                                                      Fonts().text(
                                                                          context),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontFamily: 'Text',
                                                                      // fontSize: heightSize * .025,
                                                                      color: Colors.white),
                                                                ),
                                                              ),
                                                              Padding(
                                                                  padding: EdgeInsets.only(
                                                                      top: 5,
                                                                      left: 20,
                                                                      bottom:
                                                                          heightSize *
                                                                              .01),
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                        CustomIcons
                                                                            .star_1,
                                                                        size: widthSize >
                                                                                700
                                                                            ? 25
                                                                            : 15,
                                                                        color:
                                                                            gold,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: 5),
                                                                        child: Text(
                                                                            weekly.length != 0
                                                                                ? '${weekly[0]["Rank"]}'
                                                                                : '5.0',
                                                                            textScaleFactor:
                                                                                Fonts().textSmall(context),
                                                                            style: TextStyle(
                                                                              color: gold,
                                                                              fontFamily: 'Text',
                                                                              fontWeight: FontWeight.w700,
                                                                              // fontSize:
                                                                              //     heightSize * .025,
                                                                            )),
                                                                      ),

                                                                      //   padding: EdgeInsets
                                                                      //       .only(
                                                                      //           left:
                                                                      //               5),
                                                                      //   child: Text(
                                                                      //       '(422 votes)',
                                                                      //       textScaleFactor:
                                                                      //           Fonts().textSmall(
                                                                      //               context),
                                                                      //       style:
                                                                      //           TextStyle(
                                                                      //         color: Color.fromRGBO(
                                                                      //             167,
                                                                      //             151,
                                                                      //             135,
                                                                      //             1),
                                                                      //         fontFamily:
                                                                      //             'Text',
                                                                      //         // fontSize:
                                                                      //         //     heightSize * .025,
                                                                      //       )),
                                                                      // ),
                                                                    ],
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Padding(
                                                                  padding: EdgeInsets.only(
                                                                      right:
                                                                          widthSize *
                                                                              .02,
                                                                      bottom:
                                                                          heightSize *
                                                                              .01),
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        width: widthSize *
                                                                            .15,
                                                                        height: heightSize *
                                                                            .08,
                                                                        decoration: BoxDecoration(
                                                                            // color: colorBox,
                                                                            borderRadius: BorderRadius.all(Radius.circular(20))),
                                                                        child:
                                                                            Container(
                                                                          padding: EdgeInsets.only(
                                                                              top: 10,
                                                                              left: 10,
                                                                              right: 10),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.all(Radius.circular(7)),
                                                                              child: weekly.length != 0
                                                                                  ? Image.network(
                                                                                      "${weekly[0]["CountryFlag"]}",
                                                                                      fit: BoxFit.fill,
                                                                                      height: heightSize * .045,
                                                                                    )
                                                                                  : Image.asset(
                                                                                      "assets/Flag.png",
                                                                                      fit: BoxFit.fill,
                                                                                      height: heightSize * .045,
                                                                                    ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ))
                                            ]),
                                      )
                                    : Container(
                                        child: Column(
                                        children: [
                                          Image.asset('assets/Empty.png',
                                              scale: 2.5),
                                          Text('Cigar not found',
                                              textScaleFactor:
                                                  Fonts().text(context),
                                              style: TextStyle(
                                                  fontFamily: 'Title',
                                                  color: Colors.white38)),
                                        ],
                                      ))),
                            Stack(
                              children: [
                                Divider(
                                  thickness: 1,
                                  color: Colors.white,
                                  indent: widthSize * .05,
                                  endIndent: widthSize * .85,
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.white,
                                  indent: widthSize * .85,
                                  endIndent: widthSize * .05,
                                ),
                                Center(
                                  child: Container(
                                    color: Colors.black,
                                    child: Text(
                                      'Lounges of the Week',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Title'),
                                      textScaleFactor: Fonts().text(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //     top: heightSize * .02,
                            //     left: widthSize * .05,
                            //     right: widthSize * .05,
                            //   ),
                            //   child: SingleChildScrollView(
                            //     scrollDirection: Axis.vertical,
                            //     child: Column(
                            //       children: [
                            //         Container(
                            //           height: heightSize * .12,
                            //           width: widthSize,
                            //           decoration: BoxDecoration(
                            //               color: Colors.transparent,
                            //               borderRadius:
                            //                   BorderRadius.all(Radius.circular(15))),
                            //           child: Stack(
                            //             children: [
                            //               ClipRRect(
                            //                 borderRadius:
                            //                     BorderRadius.all(Radius.circular(15)),
                            //                 child: Image.network(
                            //                   "https://stcigarappimagesdev.blob.core.windows.net/loungeimages/cigar-lounge.jpg",
                            //                   height: heightSize * .12,
                            //                   width: widthSize,
                            //                   fit: BoxFit.fill,
                            //                 ).blurred(
                            //                     blur: 3,
                            //                     blurColor:
                            //                         Color.fromARGB(255, 20, 20, 20)),
                            //               ),
                            //               Padding(
                            //                 padding:
                            //                     EdgeInsets.only(left: widthSize * .1),
                            //                 child: Column(
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment.start,
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment.center,
                            //                   children: [
                            //                     Text('Cigar Code',
                            //                         textScaleFactor:
                            //                             Fonts().text(context),
                            //                         style: TextStyle(
                            //                             fontFamily: 'Title',
                            //                             color: Colors.white)),
                            //                     Text('Luxery Smokes Saturdays',
                            //                         textScaleFactor:
                            //                             Fonts().text(context),
                            //                         style: TextStyle(
                            //                             fontFamily: 'Text',
                            //                             color: Colors.white)),
                            //                     Text(
                            //                         '939 Delaware Av. Philadelphia 19123',
                            //                         textScaleFactor:
                            //                             Fonts().textSmall(context),
                            //                         style: TextStyle(
                            //                             fontFamily: 'Text',
                            //                             fontWeight: FontWeight.bold,
                            //                             color: Color.fromRGBO(
                            //                                 197, 169, 1, 1)))
                            //                   ],
                            //                 ),
                            //               )
                            //             ],
                            //           ),
                            //         ),
                            //         Padding(
                            //             padding: EdgeInsets.symmetric(
                            //                 vertical: heightSize * .02)),
                            //         Container(
                            //           height: heightSize * .12,
                            //           width: widthSize,
                            //           decoration: BoxDecoration(
                            //               color: Colors.transparent,
                            //               borderRadius:
                            //                   BorderRadius.all(Radius.circular(15))),
                            //           child: Stack(
                            //             children: [
                            //               ClipRRect(
                            //                 borderRadius:
                            //                     BorderRadius.all(Radius.circular(15)),
                            //                 child: Image.network(
                            //                   "https://stcigarappimagesdev.blob.core.windows.net/loungeimages/cigar-lounge.jpg",
                            //                   height: heightSize * .12,
                            //                   width: widthSize,
                            //                   fit: BoxFit.fill,
                            //                 ).blurred(
                            //                     blur: 3,
                            //                     blurColor:
                            //                         Color.fromARGB(255, 20, 20, 20)),
                            //               ),
                            //               Padding(
                            //                 padding:
                            //                     EdgeInsets.only(left: widthSize * .1),
                            //                 child: Column(
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment.start,
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment.center,
                            //                   children: [
                            //                     Text('Cigar Code',
                            //                         textScaleFactor:
                            //                             Fonts().text(context),
                            //                         style: TextStyle(
                            //                             fontFamily: 'Title',
                            //                             color: Colors.white)),
                            //                     Text('Luxery Smokes Saturdays',
                            //                         textScaleFactor:
                            //                             Fonts().text(context),
                            //                         style: TextStyle(
                            //                             fontFamily: 'Text',
                            //                             color: Colors.white)),
                            //                     Text(
                            //                         '939 Delaware Av. Philadelphia 19123',
                            //                         textScaleFactor:
                            //                             Fonts().textSmall(context),
                            //                         style: TextStyle(
                            //                             fontFamily: 'Text',
                            //                             fontWeight: FontWeight.bold,
                            //                             color: Color.fromRGBO(
                            //                                 197, 169, 1, 1)))
                            //                   ],
                            //                 ),
                            //               )
                            //             ],
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: heightSize * .12,
                              ),
                              child: Stack(
                                children: [
                                  Divider(
                                    thickness: 1,
                                    color: Colors.white,
                                    indent: widthSize * .05,
                                    endIndent: widthSize * .85,
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Colors.white,
                                    indent: widthSize * .85,
                                    endIndent: widthSize * .05,
                                  ),
                                  Center(
                                    child: Container(
                                      color: Colors.black,
                                      child: Text(
                                        'Events of the Week',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Title'),
                                        textScaleFactor: Fonts().text(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(vertical: heightSize * .3),
                      child: Container(
                        height: widthSize * .2,
                        width: widthSize * .2,
                        child: CircularProgressIndicator(
                            color: Color.fromRGBO(197, 169, 1, 1)),
                      ),
                    )
            ],
          ),
        ])

        ///
        );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({required Color color, required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius - 5);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}

class _HeaderDesign extends CustomPainter {
  final Color borderColor;
  final Color backgroundColor;
  _HeaderDesign({
    required this.backgroundColor,
    required this.borderColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = backgroundColor;
    final path = new Path();
    path.lineTo(0, size.height * .6);
    path.quadraticBezierTo(
        size.width * 0.6, size.height * 1, size.width, size.height * .6);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    //LineDown
    final path2 = new Path();
    path2.moveTo(0, size.height * .6);
    path2.quadraticBezierTo(
        size.width * 0.6, size.height * 1, size.width, size.height * .6);
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9;
    canvas.drawPath(path, paint);
    canvas.drawPath(path2, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
