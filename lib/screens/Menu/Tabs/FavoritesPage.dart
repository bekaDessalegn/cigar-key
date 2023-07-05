import 'package:cigarKey/controllers/FavoritesController.dart';
import 'package:cigarKey/controllers/productsController.dart';
import 'package:cigarKey/controllers/userController.dart';
import 'package:cigarKey/providers/provider.dart';
import 'package:cigarKey/service/ApiService.dart';
import 'package:cigarKey/utils/fontSize.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  UserController user = Get.put(UserController());
  List favoriteList = [];
  bool? done;

  late TextEditingController _keyword = TextEditingController();
  String keyword = "";
  bool searching = false;

  @override
  void initState() {
    updateFavorites();

    super.initState();
  }

  void updateFavorites() async {
    done = true;
    try {
      await ApiService.getFavorites(user.email.value).then((value) => {
            if (value[0] == '200' && mounted)
              {
                setState(() {
                  favoriteList = value[1];
                  done = false;
                }),
              }
            else
              {}
          });
    } catch (e) {
      print(e);
      //ERROR POPUP
    }
  }

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;
    Color colorText = Color.fromRGBO(197, 169, 1, 1);

    ButtonStyle buttonStyleRedonde = new ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
        backgroundColor: MaterialStateProperty.all<Color>(colorText));

    var provider = Provider.of<MyProvider>(context);
    List favList = favoriteList;

    // print(favList[0].Name);
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

    return Scaffold(
      body: Container(
        width: widthSize,
        color: Color.fromRGBO(12, 10, 10, 1),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(top: heightSize * .035),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 60, top: 12),
                            child: Text(
                              'My Locker',
                              textScaleFactor: Fonts().textTitle(context),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                // fontSize: heightSize * .03,
                                fontFamily: 'Title',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Row(children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/logoBlanco.png',
                                scale: 25,
                              ),
                            ]),
                      ]),
                    ),
                  ],
                ),
              ),
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
                        // fontSize: widthSize * .045,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          hintStyle: TextStyle(
                            color: Colors.white,
                            // fontSize: widthSize * .04,
                            fontSize:
                                16 / MediaQuery.of(context).textScaleFactor,
                            fontFamily: 'Text',
                            fontWeight: FontWeight.w100,
                          ),
                          prefixIcon: Image.asset(
                            'assets/search.png',
                            scale: 1.1,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)))),
                    ),
                  ),
                ),
              ),
              // favList.length == 0
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: heightSize * .06),
                  child: Container(
                    child: done!
                        ? Center(
                            child: Container(
                            height: widthSize * .2,
                            width: widthSize * .2,
                            child: CircularProgressIndicator(
                                color: Color.fromRGBO(197, 169, 1, 1)),
                          ))
                        : favList.length == 0
                            ? Container(
                                alignment: Alignment.center,
                                height: heightSize * .6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/Empty.png',
                                      width: widthSize > 600 ? 400 : 200,
                                      // scale: widthSize > 600 ? 1.3 : 0.8,
                                    ),
                                    Text(
                                      'You have not favorites added',
                                      textAlign: TextAlign.center,
                                      textScaleFactor: Fonts().text(context),
                                      style: TextStyle(
                                          // color: Color.fromRGBO(107, 97, 100, 1),
                                          color: Colors.white,
                                          fontFamily: 'Title'),
                                      //rgba(107, 97, 100, 1)
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: heightSize * .02)),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/SuggestionsPage');
                                        },
                                        style: buttonStyleRedonde,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: heightSize * .015,
                                              horizontal: widthSize * .06),
                                          child: Text(
                                            "Go to Suggestions",
                                            textScaleFactor:
                                                Fonts().text(context),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Text',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            : Container(
                                child: GetBuilder<ProductsController>(
                                    init: ProductsController(),
                                    builder: ((_) {
                                      _.setList(favList);
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
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: widthSize * .02),
                                              child: InkWell(
                                                onTap: () {
                                                  Map args = {
                                                    // "Id": index,
                                                    "Number": _
                                                        .listFilter[index]
                                                        .Number,
                                                    "Brand": _.listFilter[index]
                                                        .Brand,
                                                    "Name": _
                                                        .listFilter[index].Name,
                                                    "Image": _.listFilter[index]
                                                        .Image,
                                                    "Description": _
                                                        .listFilter[index]
                                                        .Description,
                                                    "rate": _
                                                        .listFilter[index].Rank,
                                                    "favorite": true,
                                                    "Shape": _.listFilter[index]
                                                        .Shape,
                                                    "Color": _.listFilter[index]
                                                        .Color,
                                                    "Country": _
                                                        .listFilter[index]
                                                        .Country,
                                                    "Flavor": _
                                                        .listFilter[index]
                                                        .Flavor,
                                                    "Size": _
                                                        .listFilter[index].Size,
                                                    "CountryFlag": _
                                                        .listFilter[index]
                                                        .CountryFlag,
                                                    "flag": false,
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
                                                                  heightSize *
                                                                      .16,
                                                              width: widthSize *
                                                                  .4,
                                                              child: Card(
                                                                clipBehavior: Clip
                                                                    .antiAlias,
                                                                child: Image
                                                                    .network(
                                                                  _
                                                                      .listFilter[
                                                                          index]
                                                                      .Image,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                                // Image.asset(_.listFilter[index]['photo']),
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
                                                                        '${_.listFilter[index].Rank}.0',
                                                                        // '5.0',
                                                                        textScaleFactor:
                                                                            Fonts().textSmall(context),
                                                                        // _.listFilter[index]['rate'],
                                                                        style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            // fontSize:
                                                                            //     heightSize * .02,
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
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                              _
                                                                  .listFilter[
                                                                      index]
                                                                  .Brand,
                                                              // _.listFilter[index]['brand'],
                                                              textScaleFactor:
                                                                  Fonts().textSmall(
                                                                      context),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  // fontSize: heightSize * .02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      'Text')),
                                                          Padding(
                                                              padding: EdgeInsets.only(
                                                                  left:
                                                                      widthSize *
                                                                          .05,
                                                                  right:
                                                                      widthSize *
                                                                          .05,
                                                                  bottom:
                                                                      heightSize *
                                                                          .01),
                                                              child: Text(
                                                                  _
                                                                      .listFilter[
                                                                          index]
                                                                      .Name,
                                                                  textScaleFactor:
                                                                      Fonts().textverySmall(
                                                                          context),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  // _.listFilter[index]['name'],
                                                                  style:
                                                                      TextStyle(
                                                                          color: Color.fromRGBO(
                                                                              165,
                                                                              151,
                                                                              136,
                                                                              1),
                                                                          // fontSize: heightSize * .018,
                                                                          fontFamily:
                                                                              'Text'))),
                                                        ],
                                                      )
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
                                          });
                                    })),
                              ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
