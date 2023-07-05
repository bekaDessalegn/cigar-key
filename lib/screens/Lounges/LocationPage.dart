import 'package:cigarKey/controllers/LoungesController.dart';
import 'package:cigarKey/controllers/productsController.dart';
import 'package:cigarKey/model/ProductsModel.dart';
import 'package:cigarKey/providers/provider.dart';
import 'package:cigarKey/service/ApiService.dart';
import 'package:cigarKey/utils/MapUtils.dart';
import 'package:cigarKey/utils/notification_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:location/location.dart' as locate;
import 'package:provider/provider.dart';
import 'package:cigarKey/utils/fontSize.dart';
import 'package:cigarKey/utils/.env.dart' as env;
import 'dart:math';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  var places = [];
  var _list = [];
  // locate.Location location = new locate.Location();
  bool? loading;
  String mylat = "";
  String mylng = "";

  @override
  void initState() {
    loading = true;

    // getGooglePlaces();
    currentPosition();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // getGooglePlaces();
    super.didChangeDependencies();
  }

  Future currentPosition() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) => getGooglePlaces(
            value.latitude.toString(), value.longitude.toString()));
  }

  void getGooglePlaces(String myLat, String myLng) async {
    setState(() {
      mylat = myLat;
      mylng = myLng;
    });

    final args = {
      "Latitude": mylat,
      "Longitude": mylng,
      "DistanceRange": "100",
    };
    var placesResponse = [];
    double ddistance = 0.00;
    var sortedList = [];
    var sortedPlaces = [];
    try {
      ApiService.getLounges(args).then((response) => {
            if (response[0] == "200")
              {
                if (this.mounted)
                  {
                    setState(() => {list = response[1]}),
                    ApiService.getGoogleLounges(mylat, mylng)
                        .then((response) => {
                              if (response[0] == "200")
                                {
                                  setState(() {
                                    loading = true;
                                    placesResponse = response[1];
                                  }),
                                  for (int i = 0;
                                      i < placesResponse.length;
                                      i++)
                                    {
                                      places.add({
                                        "photoId":
                                            placesResponse[i]["photos"] != null
                                                ? placesResponse[i]["photos"][0]
                                                    ["photo_reference"]
                                                : '',
                                        "Name": placesResponse[i]["name"],
                                        "Address": placesResponse[i]
                                            ["vicinity"],
                                        "Latitude": placesResponse[i]
                                            ["geometry"]["location"]["lat"],
                                        "Longitude": placesResponse[i]
                                            ["geometry"]["location"]["lng"],
                                        "Distance": getDistance2(
                                            placesResponse[i]["geometry"]
                                                ["location"]["lat"],
                                            placesResponse[i]["geometry"]
                                                ["location"]["lng"]),
                                        "DistanceNum": getDistanceNum(
                                            placesResponse[i]["geometry"]
                                                ["location"]["lat"],
                                            placesResponse[i]["geometry"]
                                                ["location"]["lng"]),
                                      })
                                    },
                                  for (int i = 0; i < list.length; i++)
                                    {
                                      for (int j = 0; j < places.length; j++)
                                        {
                                          ddistance = getDistance(
                                            list[i]["Latitude"],
                                            list[i]["Longitude"],
                                            places[j]["Latitude"],
                                            places[j]["Longitude"],
                                          ),
                                          if (ddistance < 0.05)
                                            {
                                              setState(() {
                                                places.removeAt(j);
                                                j = places.length - 1;
                                              })
                                            }
                                        }
                                    },
                                  sortedPlaces = places
                                    ..sort((a, b) => a["DistanceNum"]
                                        .compareTo(b["DistanceNum"])),
                                  _list =
                                      [list, places].expand((x) => x).toList(),
                                  setState(() {
                                    loading = false;
                                  })
                                }
                            }),
                  }
              }
          });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  double getDistance(lat1, lng1, lat2, lng2) {
    var R = 6371;
    var dlat = deg2rad(lat2 - lat1);
    var dlng = deg2rad(lng2 - lng1);
    var a = sin(dlat / 2) * sin(dlat / 2) +
        cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dlng / 2) * sin(dlng / 2);

    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = R * c;

    return d;
  }

  double? lat1;
  double? lng1;

  void getMyLocation() async {
    lat1 = double.parse(mylat);
    lng1 = double.parse(mylng);
  }

  String getDistance2(lat2, lng2) {
    getMyLocation();
    var R = 6371;
    var dlat = deg2rad(lat2 - lat1);
    var dlng = deg2rad(lng2 - lng1);
    var a = sin(dlat / 2) * sin(dlat / 2) +
        cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dlng / 2) * sin(dlng / 2);

    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = R * c;
    var _d = (d / 1.60934).toStringAsFixed(2);

    return double.parse(_d) > 999 ? '+999 mi' : '$_d mi';
  }

    double getDistanceNum(lat2, lng2) {
    getMyLocation();
    var R = 6371;
    var dlat = deg2rad(lat2 - lat1);
    var dlng = deg2rad(lng2 - lng1);
    var a = sin(dlat / 2) * sin(dlat / 2) +
        cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dlng / 2) * sin(dlng / 2);

    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = R * c;
    var _d = (d / 1.60934).toStringAsFixed(2);

    return double.parse(_d);
  }

  double deg2rad(deg) {
    return deg * (pi / 180);
  }

  bool lounge = false;
  bool humidor = false;
  int food = 0;
  int drinks = 0;
  List<dynamic> list = [];
  late TextEditingController _keyword = TextEditingController();
  String keyword = "";
  bool searching = false;
  bool filtering = false;
  int servesFood = 0;
  int servesDrinks = 0;

  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<MyProvider>(context);
    var widthSize = MediaQuery.of(context).size.width;
    var heightSize = MediaQuery.of(context).size.height;
    Color colorText = Color.fromRGBO(197, 169, 1, 1);
    Color colorPink = Color.fromRGBO(237, 21, 86, 1);
    Color colorBlack = Color.fromRGBO(18, 16, 16, 1);
    double iconSize = MediaQuery.of(context).size.width > 450 ? 30 : 19;
    return Scaffold(
        body: Stack(children: [
      SingleChildScrollView(
        child: Container(
          color: Color.fromRGBO(12, 10, 10, 1),
          width: widthSize,
          height: heightSize,
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
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
                              'Locations',
                              textScaleFactor: Fonts().textTitle(context),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Title',
                                  // fontSize: iconSize,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      )),
                    ),
                    Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/logoBlanco.png',
                              scale: 25,
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Container(
                  child: InkWell(
                    onTap: () {
                      filterReportPopUp(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_list_outlined,
                          color: colorText,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Filters',
                            textScaleFactor: Fonts().textSmall(context),
                            style: TextStyle(
                              color: colorText,
                              fontFamily: 'Text',
                              // fontSize: heightSize * .028
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
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
              Expanded(
                child: loading!
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: heightSize * .05,
                                  ),
                                  child: Image.asset(
                                    'assets/EmptyLounges.png',
                                    scale: widthSize > 600 ? 1.3 : 2,
                                  ),
                                ),
                                Text(
                                  'No lounges nearby',
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
                        : Padding(
                            padding: EdgeInsets.only(
                                bottom: heightSize * .06, top: 10),
                            child: Container(
                              child: GetBuilder<LoungesController>(
                                init: LoungesController(),
                                builder: ((_) {
                                  _.setList(_list);
                                  _.searchLounges(keyword, searching);
                                  _.filterLounges(servesFood == 1,
                                      servesDrinks == 1, filtering);
                                  return ListView.builder(
                                    itemCount: _.listFilter.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        elevation: 5.0,
                                        margin: EdgeInsets.all(10),
                                        child: Row(children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                _.listFilter[index]
                                                            ["Address"] ==
                                                        null
                                                    ? Navigator.pushNamed(
                                                        context, '/Products')
                                                    : Navigator.pushNamed(
                                                        context,
                                                        '/ContactUsPage');
                                              },
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.17,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                        Color.fromRGBO(
                                                            34, 30, 31, 0.9),
                                                        Color.fromRGBO(
                                                            12, 10, 10, 1),
                                                      ],
                                                      stops: [0.0, 2.0],
                                                      tileMode: TileMode.clamp),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  10.0)),
                                                ),
                                                child: Row(children: [
                                                  Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.121,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.22,
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: (_.listFilter[index]["photoId"] ==
                                                                        null
                                                                    ? (Image.network(
                                                                        _.listFilter[index][
                                                                            "Image"]))
                                                                    : (_.listFilter[index]["photoId"] != ""
                                                                        ? Image.network(
                                                                            "https://maps.googleapis.com/maps/api/place/photo?photo_reference=${_.listFilter[index]['photoId']}&maxwidth=100&key=${env.googleAPIKey}",
                                                                            fit: BoxFit.fill)
                                                                        : Image.asset('assets/logoCigarkey.png')))
                                                                // Image.network(
                                                                //   _.listFilter[index]
                                                                //       ["Image"],
                                                                //   fit: BoxFit.fill,
                                                                // ),
                                                                ),
                                                          ),
                                                        ),
                                                      ]),
                                                  Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.126,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.29,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Flexible(
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      _.listFilter[
                                                                              index]
                                                                          [
                                                                          "Name"],
                                                                      textScaleFactor:
                                                                          Fonts()
                                                                              .textSmall(context),
                                                                      maxLines:
                                                                          3,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontFamily:
                                                                            'Text',
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        // fontSize:
                                                                        //     widthSize *
                                                                        //         .032
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  _.listFilter[index]
                                                                              [
                                                                              "Address"] ==
                                                                          null
                                                                      ? ' ${_.listFilter[index]["Street"]} ${_.listFilter[index]["City"]}, ${_.listFilter[index]["State"]} ${_.listFilter[index]["ZipCode"]}.'
                                                                      : '${_.listFilter[index]["Address"]}',
                                                                  textScaleFactor:
                                                                      Fonts().textverySmall(
                                                                          context),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        colorText,
                                                                    fontFamily:
                                                                        'Text',
                                                                    // fontSize:
                                                                    //     widthSize *
                                                                    //         .03
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                  _.listFilter[index]
                                                              ["Address"] ==
                                                          null
                                                      ? (Expanded(
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    colorText,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          20.0),
                                                                ),
                                                              ),
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.04,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.09,
                                                              child: Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .white,
                                                                size: iconSize,
                                                              ),
                                                            ),
                                                          ),
                                                        ))
                                                      : Container(),
                                                ]),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // MapUtils.openMap(
                                              // _.listFilter[index]["latitude"],
                                              // _.listFilter[index]["longitude"]
                                              // );
                                              final args = {
                                                "Lat": _.listFilter[index]
                                                    ["Latitude"],
                                                "Lng": _.listFilter[index]
                                                    ["Longitude"],
                                                "Plat": mylat,
                                                "Plng": mylng,
                                                "Name": _.listFilter[index]
                                                    ["Name"],
                                                "Image": _.listFilter[index]
                                                            ["photoId"] ==
                                                        null
                                                    ? _.listFilter[index]
                                                        ["Image"]
                                                    : "https://maps.googleapis.com/maps/api/place/photo?photo_reference=${_.listFilter[index]['photoId']}&maxwidth=100&key=${env.googleAPIKey}",
                                                "Address": _.listFilter[index]
                                                            ["Address"] ==
                                                        null
                                                    ? ' ${_.listFilter[index]["Street"]} ${_.listFilter[index]["City"]}, ${_.listFilter[index]["State"]} ${_.listFilter[index]["ZipCode"]}.'
                                                    : '${_.listFilter[index]["Address"]}'
                                              };
                                              Navigator.pushNamed(
                                                  context, '/MapPage',
                                                  arguments: args);
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.17,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .18,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  10.0)),
                                                  color: Color.fromRGBO(
                                                      155, 107, 55, 1)),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                              padding: EdgeInsets.only(
                                                                  bottom:
                                                                      heightSize *
                                                                          .01),
                                                              child:
                                                                  Image.asset(
                                                                'assets/find.png',
                                                                scale: 2.0,
                                                              )),
                                                          Text(
                                                            'Go to \n lounge',
                                                            textScaleFactor: Fonts()
                                                                .textverySmall(
                                                                    context),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Text',
                                                                // fontSize: widthSize * .028,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .white),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: heightSize *
                                                                  .01,
                                                            ),
                                                            child: Text(
                                                              getDistance2(
                                                                  _.listFilter[
                                                                          index]
                                                                      [
                                                                      "Latitude"],
                                                                  _.listFilter[
                                                                          index]
                                                                      [
                                                                      "Longitude"]),
                                                              textScaleFactor: Fonts()
                                                                  .textverySmall(
                                                                      context),
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Text',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  // fontSize: widthSize * .035,
                                                                  color: Colors
                                                                      .white),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ]),
                                                  ]),
                                            ),
                                          ),
                                        ]),
                                      );
                                    },
                                  );
                                }),
                              ),
                            ),
                          ),
              ),
            ]),
          ),
        ),
      ),
    ]));
  }

  filterReportPopUp(BuildContext context) {
    var myProvider = Provider.of<MyProvider>(context, listen: false);
    Color colorText = Color.fromRGBO(197, 169, 1, 1);
    ButtonStyle buttonStyleClear = new ButtonStyle(
        shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
        side: MaterialStateProperty.all(BorderSide(color: colorText)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent));
    ButtonStyle buttonStyleApply = new ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
        backgroundColor: MaterialStateProperty.all<Color>(colorText));
    Color colorBackground = Color.fromRGBO(34, 30, 31, 1);

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              backgroundColor: colorBackground,
              // title: Align(alignment: Alignment.topRight, child: Text('')),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                // width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: (() {
                          Navigator.of(context).pop();
                        }),
                        icon: Icon(Icons.close),
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .025),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .4,
                            child: CheckboxListTile(
                              checkColor: Colors.black,
                              title: Text(
                                "Lounge",
                                textScaleFactor: Fonts().textverySmall(context),
                                style: TextStyle(
                                  fontFamily: "Text",
                                  color: Colors.white,
                                ),
                              ),

                              value: lounge,
                              onChanged: (newValue) {
                                setState(() {
                                  lounge = newValue!;
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .4,
                            child: CheckboxListTile(
                              checkColor: Colors.black,
                              title: Text(
                                "Humidor",
                                textScaleFactor: Fonts().textverySmall(context),
                                style: TextStyle(
                                  fontFamily: "Text",
                                  color: Colors.white,
                                ),
                              ),
                              value: humidor,
                              onChanged: (newValue) {
                                setState(() {
                                  humidor = newValue!;
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Food",
                              textScaleFactor: Fonts().textverySmall(context),
                              style: TextStyle(
                                fontFamily: "Text",
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                      value: 1,
                                      groupValue: food,
                                      onChanged: (index) {
                                        setState((() {
                                          food = int.parse(index.toString());
                                        }));
                                      }),
                                  Text(
                                    'Yes',
                                    style: TextStyle(
                                      fontFamily: "Text",
                                      color: Colors.white,
                                    ),
                                    textScaleFactor:
                                        Fonts().textverySmall(context),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: 2,
                                      groupValue: food,
                                      onChanged: (index) {
                                        setState((() {
                                          food = int.parse(index.toString());
                                        }));
                                      }),
                                  Text(
                                    'BYO',
                                    style: TextStyle(
                                      fontFamily: "Text",
                                      color: Colors.white,
                                    ),
                                    textScaleFactor:
                                        Fonts().textverySmall(context),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Drinks",
                              textScaleFactor: Fonts().textverySmall(context),
                              style: TextStyle(
                                fontFamily: "Text",
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                      value: 1,
                                      groupValue: drinks,
                                      onChanged: (index) {
                                        setState((() {
                                          drinks = int.parse(index.toString());
                                        }));
                                      }),
                                  Text(
                                    'Full bar',
                                    style: TextStyle(
                                      fontFamily: "Text",
                                      color: Colors.white,
                                    ),
                                    textScaleFactor:
                                        Fonts().textverySmall(context),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: 2,
                                      groupValue: drinks,
                                      onChanged: (index) {
                                        setState((() {
                                          drinks = int.parse(index.toString());
                                        }));
                                      }),
                                  Text(
                                    'BYO',
                                    style: TextStyle(
                                      fontFamily: "Text",
                                      color: Colors.white,
                                    ),
                                    textScaleFactor:
                                        Fonts().textverySmall(context),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .27,
                        child: ElevatedButton(
                            style: buttonStyleClear,
                            onPressed: () {
                              setState((() {
                                lounge = false;
                                food = 0;
                                drinks = 0;
                                servesFood = 0;
                                servesDrinks = 0;
                                humidor = false;
                                filtering = false;
                              }));
                              myProvider.humidor = false;
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Clear All",
                              textScaleFactor: Fonts().textSmall(context),
                              style: TextStyle(
                                fontFamily: "Text",
                                color: colorText,
                                fontWeight: FontWeight.bold,
                                // fontSize: MediaQuery.of(context).size.width > 450
                                //     ? MediaQuery.of(context).size.width > 700
                                //         ? 35
                                //         : 20
                                //     : 16,
                              ),
                            )),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .27,
                        child: ElevatedButton(
                            style: buttonStyleApply,
                            onPressed: () {
                              myProvider.humidor = humidor;
                              setState(() {
                                filtering = true;
                                servesFood = food;
                                servesDrinks = drinks;
                              });
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Apply",
                              textScaleFactor: Fonts().textSmall(context),
                              style: TextStyle(
                                fontFamily: "Bold",
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                // fontSize: MediaQuery.of(context).size.width > 450
                                //     ? MediaQuery.of(context).size.width > 700
                                //         ? 35
                                //         : 20
                                //     : 16,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            );
          });
        }).then((value) => {myProvider.humidor = value});
  }
}
