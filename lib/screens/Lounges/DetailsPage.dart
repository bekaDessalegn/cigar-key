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

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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
                      if (favorites.length == 0)
                        {
                          setState(() {
                            similarlist.add({
                              "brand": recomendations[i]["Brand"],
                              "name": recomendations[i]["Name"],
                              "rate": recomendations[i]["Rank"],
                              "photo": recomendations[i]["Image"],
                              "number": recomendations[i]["Number"],
                              "description": recomendations[i]["Description"],
                              "favorite": false,
                              "Strength": recomendations[i]["Strength"],
                              "Shape": recomendations[i]["Shape"],
                              "Color": recomendations[i]["Color"],
                              "Country": recomendations[i]["Country"],
                              "Flavor": recomendations[i]["Flavor"],
                              "Size": recomendations[i]["Size"],
                              "CountryFlag": recomendations[i]["CountryFlag"],
                            });
                          })
                        }
                      else
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
                                      "rate": recomendations[i]["Rank"],
                                      "photo": recomendations[i]["Image"],
                                      "number": recomendations[i]["Number"],
                                      "description": recomendations[i]
                                          ["Description"],
                                      "favorite": true,
                                      "Strength": recomendations[i]["Strength"],
                                      "Shape": recomendations[i]["Shape"],
                                      "Color": recomendations[i]["Color"],
                                      "Country": recomendations[i]["Country"],
                                      "Flavor": recomendations[i]["Flavor"],
                                      "Size": recomendations[i]["Size"],
                                      "CountryFlag": recomendations[i]
                                          ["CountryFlag"],
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
                                      "rate": recomendations[i]["Rank"],
                                      "photo": recomendations[i]["Image"],
                                      "number": recomendations[i]["Number"],
                                      "description": recomendations[i]
                                          ["Description"],
                                      "favorite": false,
                                      "Strength": recomendations[i]["Strength"],
                                      "Shape": recomendations[i]["Shape"],
                                      "Color": recomendations[i]["Color"],
                                      "Country": recomendations[i]["Country"],
                                      "Flavor": recomendations[i]["Flavor"],
                                      "Size": recomendations[i]["Size"],
                                      "CountryFlag": recomendations[i]
                                          ["CountryFlag"],
                                    });
                                  })
                                }
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
      } catch (e) {
        print(e);
        setState(() {
          loading = false;
        });
      }
    }
  }

  bool readMore = false;

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
    Color colorRed = Color.fromRGBO(156, 27, 23, 1);

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
                                    args["Image"],
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
                                      // provider.similar = false;
                                      // provider.index =
                                      //     args["scan"] != null ? 0 : 3;
                                      // Navigator.pop(context);
                                      // args["flag"] == true
                                      //     ? args["products"] != null
                                      //         ? Navigator.popAndPushNamed(
                                      //             context, "/Products")
                                      //         : Navigator.popAndPushNamed(
                                      //             context, "/SuggestionsPage")
                                      //     :
                                      Navigator.pop(context);
                                      // Navigator.pushAndRemoveUntil(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             TabBarPage()),
                                      //     (Route<dynamic> route) => false,
                                      //   );
                                    },
                                    child: Image.asset(
                                      "assets/Back.png",
                                      scale: 1.3,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      final params = {
                                        "UserEmail": "${user.email.value}",
                                        "Products": [args['Number']]
                                      };
                                      args["favorite"]
                                          ? deleteFavorite(params)
                                          : setFavorite(params);
                                    },
                                    child: Image.asset(
                                      args["favorite"]
                                          ? "assets/FavoriteSelected.png"
                                          : "assets/Favorite.png",
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 15, left: 20),
                                              child: Text(
                                                product.brand.value.length != 0
                                                    ? product.brand.value
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
                                                      child: Text(
                                                          '${args["rate"]}.0',
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 5, left: 5, right: 10),
                                              child: Container(
                                                width: widthSize * .32,
                                                height: heightSize * .08,
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  7)),
                                                      child: Image.network(
                                                        args["CountryFlag"],
                                                        fit: BoxFit.fill,
                                                        height:
                                                            heightSize * .045,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 5, left: 5, right: 15),
                                            child: Container(
                                              width: widthSize * .32,
                                              height: heightSize * .075,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: ElevatedButton(
                                                    child: Text(
                                                      'Find now',
                                                      textScaleFactor: Fonts()
                                                          .textButton(context),
                                                    ),
                                                    onPressed: () {
                                                      provider.index = 1;
                                                      Navigator
                                                          .pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                TabBarPage()),
                                                        (Route<dynamic>
                                                                route) =>
                                                            false,
                                                      );
                                                      //widget.tabController.animateTo(1);
                                                    },
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty.all(
                                                                colorRed),
                                                        foregroundColor:
                                                            MaterialStateProperty.all(
                                                                Colors.white),
                                                        textStyle: MaterialStateProperty.all<
                                                                TextStyle>(
                                                            TextStyle(
                                                                // fontSize: heightSize * .022,
                                                                fontFamily:
                                                                    'Text',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                        shape: MaterialStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(18),
                                                                side: BorderSide(style: BorderStyle.none))))),
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
                                          : args["Description"],
                                      // args['Description'] != null
                                      //     ? args['Description']
                                      //     : '',
                                      // 'Under-the-counter and over the top with flavor, Alec Bradley Black Market Esteli cigars are what we?re smoking....',
                                      textScaleFactor:
                                          Fonts().textSmall(context),
                                      textAlign: TextAlign.justify,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: readMore ? 100 : 2,
                                      style: TextStyle(
                                          fontFamily: 'Text',
                                          fontWeight: FontWeight.w100,
                                          color: Colors.white),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            readMore = !readMore;
                                          });
                                        },
                                        child: Text(
                                          readMore ? 'Read Less' : 'Read More',
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: widthSize * .3,
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
                                                Text(
                                                    product.strength.value != -1
                                                        ? '${product.strength.value}'
                                                        : '${args["Strength"]}',
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
                                          Container(
                                            width: widthSize * .3,
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
                                                Text(args["Shape"],
                                                    textScaleFactor: Fonts()
                                                        .textSmall(context),
                                                    textAlign: TextAlign.start,
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
                                          Container(
                                            width: widthSize * .3,
                                            child: Column(
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
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      // fontSize: heightSize * .020,
                                                    )),
                                                Text(args["Color"],
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
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: widthSize * .3,
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
                                                Text(args["Country"],
                                                    textScaleFactor: Fonts()
                                                        .textSmall(context),
                                                    textAlign: TextAlign.start,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontFamily: 'Text',
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      color: Colors.white,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: widthSize * .3,
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
                                                Text(args["Flavor"],
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
                                          Container(
                                            width: widthSize * .3,
                                            child: Column(
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
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      // fontSize: heightSize * .020,
                                                    )),
                                                Text(args["Size"],
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
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        'similar products',
                                        textScaleFactor:
                                            Fonts().textTitle(context),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontFamily: 'Title',
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Container(
                                        height: heightSize * .28,
                                        width: widthSize,
                                        // color: Colors.blueGrey,
                                        child: ListView.builder(
                                          itemCount: similarlist.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, i) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: widthSize * .02),
                                              child: InkWell(
                                                onTap: () {
                                                  Map args = {
                                                    "Name": similarlist[i]
                                                        ["name"],
                                                    "Brand": similarlist[i]
                                                        ["brand"],
                                                    "Description":
                                                        similarlist[i]
                                                            ["description"],
                                                    "Image": similarlist[i]
                                                        ["photo"],
                                                    "rate": similarlist[i]
                                                        ["rate"],
                                                    "favorite": similarlist[i]
                                                        ["favorite"],
                                                    "Strength": similarlist[i]
                                                        ["Strength"],
                                                    "Number": similarlist[i]
                                                        ["number"],
                                                    "Shape": similarlist[i]
                                                        ["Shape"],
                                                    "Color": similarlist[i]
                                                        ["Color"],
                                                    "Country": similarlist[i]
                                                        ["Country"],
                                                    "Flavor": similarlist[i]
                                                        ["Flavor"],
                                                    "Size": similarlist[i]
                                                        ["Size"],
                                                    "CountryFlag":
                                                        similarlist[i]
                                                            ["CountryFlag"],
                                                    "flag": false
                                                  };
                                                  Navigator.popAndPushNamed(
                                                      context, '/DetailsPage',
                                                      arguments: args);
                                                },
                                                child: Container(
                                                  width: widthSize * .37,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            heightSize * .015),
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              width: widthSize *
                                                                  .4,
                                                              height:
                                                                  heightSize *
                                                                      .14,
                                                              child: Card(
                                                                clipBehavior: Clip
                                                                    .antiAlias,
                                                                child: Image
                                                                    .network(
                                                                  similarlist[i]
                                                                      ['photo'],
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            24)),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top:
                                                                    heightSize *
                                                                        .004,
                                                                right:
                                                                    heightSize *
                                                                        .004,
                                                              ),
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      heightSize *
                                                                          .05,
                                                                  width:
                                                                      widthSize *
                                                                          .15,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .star,
                                                                        color: Colors
                                                                            .white,
                                                                        size: heightSize *
                                                                            .025,
                                                                      ),
                                                                      Text(
                                                                        '${similarlist[i]['rate']}.0',
                                                                        textScaleFactor:
                                                                            Fonts().textSmall(context),
                                                                        style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            // fontSize:
                                                                            //     heightSize *
                                                                            //         .02,
                                                                            fontFamily: 'Text'),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: Color.fromRGBO(
                                                                              144,
                                                                              90,
                                                                              33,
                                                                              .9),
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topRight:
                                                                                Radius.circular(24),
                                                                            bottomLeft:
                                                                                Radius.circular(24),
                                                                          )),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                          similarlist[i]
                                                              ['brand'],
                                                          textScaleFactor:
                                                              Fonts().textSmall(
                                                                  context),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              // fontSize:
                                                              //     heightSize * .02,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Text')),
                                                      Text(
                                                          similarlist[i]
                                                              ['name'],
                                                          textScaleFactor:
                                                              Fonts()
                                                                  .textverySmall(
                                                                      context),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      165,
                                                                      151,
                                                                      136,
                                                                      1),
                                                              // fontSize:
                                                              //     heightSize * .018,
                                                              fontFamily:
                                                                  'Text')),
                                                    ],
                                                  ),
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Color.fromRGBO(34,
                                                                30, 31, 0.9),
                                                            Color.fromRGBO(
                                                                12, 10, 10, 1),
                                                          ],
                                                          stops: [0.0, 2.0],
                                                          tileMode:
                                                              TileMode.clamp),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24)),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
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
