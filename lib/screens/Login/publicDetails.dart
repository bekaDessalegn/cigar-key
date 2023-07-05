import 'package:cigarKey/controllers/productsController.dart';
import 'package:cigarKey/presentation/custom__icons_icons.dart';
import 'package:cigarKey/providers/provider.dart';
import 'package:cigarKey/service/ApiService.dart';
import 'package:cigarKey/utils/fontSize.dart';
import 'package:cigarKey/screens/Menu/TabBarPage.dart';
import 'package:cigarKey/widgets/ErrorPopup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:cigarKey/controllers/userController.dart';

class PublicDetails extends StatefulWidget {
  const PublicDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<PublicDetails> createState() => _PublicDetails();
}

class _PublicDetails extends State<PublicDetails> {
  UserController user = Get.put(UserController());
  List<Map> similarlist = [];
  List recomendations = [];
  List favorites = [];
  bool loading = true;

  void getRecomendations() async {
    if (this.mounted && loading) {
      try {
        setState(() {
          loading = true;
        });
        var args = {"Email": user.email.value};

        await ApiService.getFavorites(user.email.value).then((response) => {
              if (response[0] == "200")
                {
                  setState(() {
                    favorites = response[1];
                  })
                }
              else
                {
                  setState(() {
                    loading = false;
                  })
                }
            });

        await ApiService.getRecomendations(args).then((value) => {
              if (value[0] == "200")
                {
                  setState(() {
                    recomendations = value[1];
                  }),
                  for (int i = 0; i < recomendations.length; i++)
                    {
                      for (int j = 0; j < favorites.length; j++)
                        {
                          if (recomendations[i]["Number"] ==
                              favorites[j].Number)
                            {
                              setState(() {
                                similarlist.add({
                                  "brand": recomendations[i]["Brand"],
                                  "name": recomendations[i]["Name"],
                                  "rate": recomendations[i]["Rate"],
                                  "photo": recomendations[i]["Image"],
                                  "description": recomendations[i]
                                      ["Description"],
                                  "favorite": true
                                });
                                j = favorites.length - 1;
                              })
                            }
                          else if (j == favorites.length - 1)
                            {
                              setState(() {
                                similarlist.add({
                                  "brand": recomendations[i]["Brand"],
                                  "name": recomendations[i]["Name"],
                                  "rate": recomendations[i]["Rate"],
                                  "photo": recomendations[i]["Image"],
                                  "description": recomendations[i]
                                      ["Description"],
                                  "favorite": false
                                });
                              })
                            }
                        }
                    },
                  setState(() {
                    loading = false;
                  })
                }
              else
                {
                  setState(() {
                    loading = false;
                  })
                }
            });
        print(similarlist);
      } catch (e) {
        print(e);
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    getRecomendations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    var provider = Provider.of<MyProvider>(context);
    ProductsController product = Get.put(ProductsController());
    int? num;
    product.brand.isNotEmpty ? num = 0 : null;
    switch (provider.myTest) {
      case "beets":
        num = 2;
        break;
      case "pinea":
        num = 0;
        break;
      case "dates":
        num = 1;
        break;
      default:
    }

    var widthSize = MediaQuery.of(context).size.width;
    var heightSize = MediaQuery.of(context).size.height;
    Color gold = Color.fromRGBO(201, 151, 23, 1);
    Color colorBox = Color.fromRGBO(18, 16, 16, 0.7);
    Color colorPink = Color.fromRGBO(235, 27, 88, 0.7);

    void setFavorite(params) async {
      await ApiService.addUserFavorite(params).then((value) => {
            if (value[0] == "200")
              {
                setState(() {
                  args["favorite"] = !args["favorite"];
                }),
              }
            else if (value[0] == "400")
              {
                ErrorPopUp.errorPopUp(context, value[1]),
              }
            else
              {
                ErrorPopUp.errorPopUp(context, value[1]),
              }
          });
    }

    void deleteFavorite(params) async {
      await ApiService.deleteUserFavorite(params).then((value) => {
            if (value[0] == "200")
              {
                setState(() {
                  args["favorite"] = !args["favorite"];
                }),
              }
            else if (value[0] == "400")
              {
                ErrorPopUp.errorPopUp(context, value[1]),
              }
            else
              {
                ErrorPopUp.errorPopUp(context, value[1]),
              }
          });
    }

    return Scaffold(
      body: Stack(children: [
        Container(
          color: Color.fromRGBO(12, 10, 10, 1),
          width: widthSize,
          height: heightSize,
        ),
        loading
            ? Center(
                child: Container(
                height: widthSize * .2,
                width: widthSize * .2,
                child: CircularProgressIndicator(
                    color: Color.fromRGBO(197, 169, 1, 1)),
              ))
            : Container(
                width: widthSize,
                height: heightSize,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 30, left: 15, right: 15),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32))),
                        alignment: Alignment.center,
                        height: heightSize * .5,
                        width: widthSize,
                        child: Stack(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                            child: product.image.value.isNotEmpty
                                ? Image.network(product.image.value,
                                    fit: BoxFit.fill,
                                    height: heightSize * .5,
                                    width: widthSize)
                                : Image.network(
                                    provider.mySimilar
                                        ? similarlist[num!]["photo"]
                                        : args["Image"],
                                    fit: BoxFit.fill,
                                    height: heightSize * .5,
                                    width: widthSize,
                                  ),
                          ),
                          Container(
                              padding:
                                  EdgeInsets.only(top: 10, left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      provider.similar = false;
                                      provider.index = 3;
                                      Navigator.pop(context);
                                    },
                                    child: Image.asset(
                                      "assets/Back.png",
                                      scale: 1.3,
                                    ),
                                  ),
                                ],
                              )),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: widthSize,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(79, 47, 14, 0.98),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32))),
                                height: heightSize * .19,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 15, left: 20),
                                              child: Text(
                                                product.brand.value.length != 0
                                                    ? product.brand.value
                                                    : provider.mySimilar
                                                        ? similarlist[num!]
                                                            ["brand"]
                                                        : args["Brand"],
                                                // "${args![""]}",
                                                // args['Brand'] != null
                                                //     ? args['Brand']
                                                //     : '',
                                                // 'Churchill',
                                                textScaleFactor:
                                                    Fonts().text(context),
                                                textAlign: TextAlign.start,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontFamily: 'Text',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w700,
                                                    // fontSize: heightSize * .028,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 2, left: 20),
                                              child: Text(
                                                product.name.value.length != 0
                                                    ? product.name.value
                                                    : provider.mySimilar
                                                        ? similarlist[num!]
                                                            ["name"]
                                                        : args["Name"],
                                                // args['Name'] != null ? args['Name'] : '',
                                                // 'Alec Bradley',
                                                textScaleFactor:
                                                    Fonts().text(context),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontFamily: 'Text',
                                                    // fontSize: heightSize * .025,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 5, left: 20),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      CustomIcons.star_1,
                                                      size: widthSize > 700
                                                          ? 25
                                                          : 15,
                                                      color: gold,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5),
                                                      child: Text('5.0',
                                                          textScaleFactor:
                                                              Fonts().textSmall(
                                                                  context),
                                                          style: TextStyle(
                                                            color: gold,
                                                            fontFamily: 'Text',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            // fontSize:
                                                            //     heightSize * .025,
                                                          )),
                                                    ),
                                                    // Padding(
                                                    //   padding: EdgeInsets.only(
                                                    //       left: 5),
                                                    //   child: Text('(422 votes)',
                                                    //       textScaleFactor:
                                                    //           Fonts().textSmall(
                                                    //               context),
                                                    //       style: TextStyle(
                                                    //         color:
                                                    //             Color.fromRGBO(
                                                    //                 167,
                                                    //                 151,
                                                    //                 135,
                                                    //                 1),
                                                    //         fontFamily: 'Text',
                                                    //         // fontSize:
                                                    //         //     heightSize * .025,
                                                    //       )),
                                                    // ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 5, left: 5, right: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Container(
                                                      width: widthSize * .15,
                                                      height: heightSize * .08,
                                                      decoration: BoxDecoration(
                                                          color: colorBox,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          '6x54',
                                                          textScaleFactor:
                                                              Fonts().textSmall(
                                                                  context),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Text',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              // fontSize:
                                                              //     heightSize * .023,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: widthSize * .15,
                                                    height: heightSize * .08,
                                                    decoration: BoxDecoration(
                                                        color: colorBox,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10, right: 10),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          7)),
                                                          child: Image.asset(
                                                            "assets/Flag.png",
                                                            fit: BoxFit.fill,
                                                            height: heightSize *
                                                                .045,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 5, left: 5, right: 15),
                                            child: Container(
                                              width: widthSize * .32,
                                              height: heightSize * .075,
                                              decoration: BoxDecoration(
                                                  color: colorBox,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Strong',
                                                  textScaleFactor:
                                                      Fonts().text(context),
                                                  style: TextStyle(
                                                      fontFamily: 'Text',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      // fontSize: heightSize * .025,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ))
                        ]),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 15, top: 25, right: 15),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'description',
                                      textScaleFactor:
                                          Fonts().textTitle(context),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontFamily: 'Title',
                                          color: Colors.white),
                                    ),
                                    Text(
                                      product.description.value.length != 0
                                          ? product.description.value
                                          : provider.mySimilar
                                              ? similarlist[num!]["description"]
                                              : args["Description"],
                                      // args['Description'] != null
                                      //     ? args['Description']
                                      //     : '',
                                      // 'Under-the-counter and over the top with flavor, Alec Bradley Black Market Esteli cigars are what we?re smoking....',
                                      textScaleFactor:
                                          Fonts().textSmall(context),
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontFamily: 'Text',
                                          fontWeight: FontWeight.w100,
                                          color: Colors.white),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Text(
                                          'Read More',
                                          textScaleFactor:
                                              Fonts().text(context),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              // fontSize: widthSize * 0.034,
                                              color: Color.fromRGBO(
                                                  79, 47, 14, 1)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        'specifications',
                                        textScaleFactor:
                                            Fonts().textTitle(context),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontFamily: 'Title',
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: heightSize * 0.01),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: widthSize * 0.20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('Strength',
                                                    textScaleFactor: Fonts()
                                                        .textSmall(context),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          167, 151, 135, 1),
                                                      fontFamily: 'Text',
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      // fontSize: heightSize * .020,
                                                    )),
                                                Text('Strong',
                                                    textScaleFactor: Fonts()
                                                        .textSmall(context),
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                      fontFamily: 'Text',
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      // fontSize: heightSize * .020,
                                                      color: Colors.white,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: widthSize * 0.17),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('Shape',
                                                    textScaleFactor: Fonts()
                                                        .textSmall(context),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          167, 151, 135, 1),
                                                      fontFamily: 'Text',
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      // fontSize: heightSize * .020,
                                                    )),
                                                Text('Double Toro',
                                                    textScaleFactor: Fonts()
                                                        .textSmall(context),
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                      fontFamily: 'Text',
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      // fontSize: heightSize * .020,
                                                      color: Colors.white,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Color',
                                                  textScaleFactor: Fonts()
                                                      .textSmall(context),
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        167, 151, 135, 1),
                                                    fontFamily: 'Text',
                                                    fontWeight: FontWeight.w100,
                                                    // fontSize: heightSize * .020,
                                                  )),
                                              Text('Natural',
                                                  textScaleFactor: Fonts()
                                                      .textSmall(context),
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    fontFamily: 'Text',
                                                    fontWeight: FontWeight.w100,
                                                    // fontSize: heightSize * .020,
                                                    color: Colors.white,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: widthSize * .18),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('Country',
                                                    textScaleFactor: Fonts()
                                                        .textSmall(context),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          167, 151, 135, 1),
                                                      fontFamily: 'Text',
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      // fontSize: heightSize * .020,
                                                    )),
                                                Text('Nicaragua',
                                                    textScaleFactor: Fonts()
                                                        .textSmall(context),
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                      fontFamily: 'Text',
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      // fontSize: heightSize * .020,
                                                      color: Colors.white,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: widthSize * .20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('Flavor',
                                                    textScaleFactor: Fonts()
                                                        .textSmall(context),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          167, 151, 135, 1),
                                                      fontFamily: 'Text',
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      // fontSize: heightSize * .020,
                                                    )),
                                                Text('Sweet Tip',
                                                    textScaleFactor: Fonts()
                                                        .textSmall(context),
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                      fontFamily: 'Text',
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      // fontSize: heightSize * .020,
                                                      color: Colors.white,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Size',
                                                  textScaleFactor: Fonts()
                                                      .textSmall(context),
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        167, 151, 135, 1),
                                                    fontFamily: 'Text',
                                                    fontWeight: FontWeight.w100,
                                                    // fontSize: heightSize * .020,
                                                  )),
                                              Text('6x54',
                                                  textScaleFactor: Fonts()
                                                      .textSmall(context),
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    fontFamily: 'Text',
                                                    fontWeight: FontWeight.w100,
                                                    // fontSize: heightSize * .020,
                                                    color: Colors.white,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
      ]),
    );
  }
}
