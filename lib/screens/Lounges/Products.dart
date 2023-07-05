import 'package:cigarKey/controllers/productsController.dart';
import 'package:cigarKey/controllers/userController.dart';
import 'package:cigarKey/model/favoritesModel.dart';
import 'package:cigarKey/providers/provider.dart';
import 'package:cigarKey/utils/fontSize.dart';
import 'package:cigarKey/widgets/ErrorPopup.dart';
import 'package:cigarKey/widgets/GeneralHeader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../model/ProductsModel.dart';
import '../../service/ApiService.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  UserController user = Get.put(UserController());
  late TextEditingController _keyword = TextEditingController();
  String keyword = "";
  bool searching = false;
  List _list = [];
  List _listFavorites = [];
  bool? isfavorite;
  bool? done;

  @override
  void initState() {
    callApi();
    //callApi();
    super.initState();
  }

  void callApi() async {
    done = true;
    try {
      final arg = {"ProductsNumber": []};
      ApiService.allProducts(arg).then((value) => {
            if (value[0] == '200')
              {
                if (this.mounted)
                  {
                    setState(() {
                      _list = value[1];
                    }),
                    ApiService.getFavorites(user.email.value)
                        .then(((favorites) => {
                              if (favorites[0] == '200')
                                {
                                  if (this.mounted)
                                    {
                                      setState(() {
                                        _listFavorites = favorites[1]
                                            .where((element) => _list.any(
                                                (element1) =>
                                                    element1.Number ==
                                                    element.Number))
                                            .toList();
                                        done = false;
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
                            })),
                  }
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
    } catch (e) {
      ErrorPopUp.errorPopUp(context, "Occurred an error Please try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    int? num;
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
    Color colorText = Color.fromRGBO(197, 169, 1, 1);
    // double iconSize = MediaQuery.of(context).size.width > 450 ? 30 : 20;
    return Scaffold(
        body: Container(
      color: Color.fromRGBO(12, 10, 10, 1),
      child: Column(children: [
        GeneralHeader(MediaQuery.of(context).size.height * .2, "All Products"),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(left: 10, top: 30, right: 10),
            child: Container(
              height: heightSize * .085,
              width: widthSize,
              child: TextField(
                controller: _keyword,
                onChanged: (value) {
                  setState(() {
                    if (value.length > 0) {
                      keyword = value;
                      searching = true;
                    } else {
                      keyword = "";
                      searching = false;
                    }
                  });
                },
                cursorColor: Color.fromARGB(255, 196, 168, 37),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16 / MediaQuery.of(context).textScaleFactor,
                  fontFamily: 'Text',
                ),
                decoration: InputDecoration(
                    fillColor: Color.fromRGBO(53, 47, 49, 1),
                    filled: true,
                    hintText: 'Search',
                    prefixIconColor: Colors.white,
                    iconColor: Colors.white,
                    focusColor: colorText,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    hintStyle: TextStyle(
                      color: Colors.white,
                      // fontSize: widthSize * .04,
                      fontSize: 16 / MediaQuery.of(context).textScaleFactor,
                      fontFamily: 'Text',
                      fontWeight: FontWeight.w100,
                    ),
                    prefixIcon: Image.asset(
                      'assets/search.png',
                      scale: 1.1,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)))),
              ),
            ),
          ),
        ),
        // _list.length != 0
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
              child: done!
                  ? Center(
                      child: Container(
                      height: widthSize * .2,
                      width: widthSize * .2,
                      child: CircularProgressIndicator(
                          color: Color.fromRGBO(197, 169, 1, 1)),
                    ))
                  : _list.length == 0
                      ? Container(
                          alignment: Alignment.center,
                          height: heightSize * .6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/Empty.png',
                                scale: widthSize > 600 ? 1.3 : 0.8,
                              ),
                              Text(
                                'This lounge has not products',
                                textAlign: TextAlign.center,
                                textScaleFactor: Fonts().text(context),
                                style: TextStyle(
                                    // color: Color.fromRGBO(107, 97, 100, 1),
                                    color: Colors.white,
                                    fontFamily: 'Title'),
                                //rgba(107, 97, 100, 1)
                              ),
                            ],
                          ),
                        )
                      : Container(
                          child: GetBuilder<ProductsController>(
                              init: ProductsController(),
                              builder: ((_) {
                                _.setList(_list);
                                _.searchProducts(keyword, searching);
                                return GridView.builder(
                                    itemCount: _.listFilter.length,
                                    padding: EdgeInsets.all(10),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 7,
                                            childAspectRatio: 0.8,
                                            crossAxisSpacing: 20),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: widthSize * .02),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              isfavorite = _listFavorites.any(
                                                  (element) =>
                                                      element.Number ==
                                                      _.listFilter[index]
                                                          .Number);
                                            });
                                            Map args = {
                                              // "Id": index,
                                              "Number":
                                                  _.listFilter[index].Number,
                                              "Brand":
                                                  _.listFilter[index].Brand,
                                              "Name": _.listFilter[index].Name,
                                              "Image":
                                                  _.listFilter[index].Image,
                                              "Description": _.listFilter[index]
                                                  .Description,
                                              "rate": _.listFilter[index].Rank,
                                              "favorite": isfavorite,
                                              "Shape":
                                                  _.listFilter[index].Shape,
                                              "Color":
                                                  _.listFilter[index].Color,
                                              "Country":
                                                  _.listFilter[index].Country,
                                              "Flavor":
                                                  _.listFilter[index].Flavor,
                                              "Size": _.listFilter[index].Size,
                                              "CountryFlag": _.listFilter[index]
                                                  .CountryFlag,
                                              "flag": true,
                                              "products": true,
                                            };
                                            Navigator.pushNamed(
                                                context, "/DetailsPage",
                                                arguments: args);
                                            //Navigator.pushNamed(context, "/DetailsPage");
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
                                                        height:
                                                            heightSize * .18,
                                                        width: widthSize * .4,
                                                        child: Card(
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          child: Image.network(
                                                            _.listFilter[index]
                                                                .Image,
                                                            fit: BoxFit.fill,
                                                          ),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24)),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top:
                                                              heightSize * .004,
                                                          right:
                                                              heightSize * .004,
                                                        ),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Container(
                                                            height: heightSize *
                                                                .05,
                                                            width:
                                                                widthSize * .15,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .white,
                                                                  size:
                                                                      heightSize *
                                                                          .025,
                                                                ),
                                                                Text(
                                                                  '${_.listFilter[index].Rank}.0',
                                                                  textScaleFactor:
                                                                      Fonts().textSmall(
                                                                          context),
                                                                  // strongList[index]['rate'],
                                                                  style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontWeight: FontWeight.bold,
                                                                      // fontSize: heightSize * .02,
                                                                      fontFamily: 'Text'),
                                                                )
                                                              ],
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            144,
                                                                            90,
                                                                            33,
                                                                            .9),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              24),
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              24),
                                                                    )),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Text(_.listFilter[index].Brand,
                                                    // strongList[index]['brand'],
                                                    textScaleFactor: Fonts()
                                                        .textSmall(context),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        // fontSize: heightSize * .02,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Text')),
                                                Text(_.listFilter[index].Name,
                                                    textScaleFactor: Fonts()
                                                        .textverySmall(context),
                                                    // strongList[index]['name'],
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            165, 151, 136, 1),
                                                        // fontSize: heightSize * .018,
                                                        fontFamily: 'Text')),
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color.fromRGBO(
                                                          34, 30, 31, 0.9),
                                                      Color.fromRGBO(
                                                          12, 10, 10, 1),
                                                    ],
                                                    stops: [0.0, 2.0],
                                                    tileMode: TileMode.clamp),
                                                borderRadius:
                                                    BorderRadius.circular(24)),
                                          ),
                                        ),
                                      );
                                    });
                              })),
                        ),
            ),
          ),
        ),
      ]),
    ));
  }
}
