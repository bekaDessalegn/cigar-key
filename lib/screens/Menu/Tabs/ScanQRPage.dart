// import 'package:cigarKey/controllers/userController.dart';
import 'package:cigarKey/service/ApiService.dart';
import 'package:cigarKey/utils/fontSize.dart';
import 'package:cigarKey/widgets/ErrorPopup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:cigarKey/controllers/userController.dart';

class ScanQRMenu extends StatefulWidget {
  const ScanQRMenu({Key? key}) : super(key: key);

  @override
  State<ScanQRMenu> createState() => _ScanQRMenuState();
}

class _ScanQRMenuState extends State<ScanQRMenu> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  var byId = {};
  bool isDone = false;
  Barcode? barcode;
  QRViewController? controller;
  UserController user = Get.put(UserController());

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller?.resumeCamera();

    var widthSize = MediaQuery.of(context).size.width;
    // var heightSize = MediaQuery.of(context).size.height;
    double iconSize = MediaQuery.of(context).size.width > 450 ? 30 : 20;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          QRView(
              key: qrKey,
              onQRViewCreated: onQRviewCreated,
              overlay: QrScannerOverlayShape(
                  // borderColor: isDone ? Colors.red : Colors.white,
                  overlayColor: isDone
                      ? Color.fromRGBO(0, 0, 0, 0.3)
                      : Color.fromRGBO(0, 0, 0, 0.8),
                  borderRadius: 10,
                  borderLength: 0,
                  cutOutSize: MediaQuery.of(context).size.width * 0.8)),
          isDone
              ? Positioned(
                  top: 450,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Container(
                        height: widthSize * .2,
                        width: widthSize * .2,
                        child: CircularProgressIndicator(
                            color: Color.fromRGBO(197, 169, 1, 1)),
                      )),
                    ],
                  ))
              : Container(),
          //  Center(
          //     child: CircularProgressIndicator(
          //         color: Color.fromRGBO(240, 121, 0, 1))),
          // Positioned(
          //     bottom: 100,
          //     child: Container(
          //         padding: EdgeInsets.all(12),
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(8),
          //             color: Colors.white),
          //         child: Text(
          //           barcode != null
          //               ? 'Result: ${barcode!.code}'
          //               : 'Scan a code!',
          //           maxLines: 3,
          //         ))),
          Positioned(
              top: 150,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Scan the product with your camara and wait',
                    textScaleFactor: Fonts().textSmall(context),
                    style: TextStyle(
                        fontFamily: 'Text',
                        // fontSize: widthSize * .035,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
          Positioned(
            top: 40,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 120, right: 70),
                      child: Text(
                        'Scan',
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
                Container(
                  alignment: Alignment.topRight,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 15, right: 10),
                                child: Image.asset(
                                  'assets/logoBlanco.png',
                                  scale: 25,
                                ),
                              ),
                            ]),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onQRviewCreated(QRViewController controller) {
    Map args = {};
    List favs = [];
    setState(() => {this.controller = controller, isDone = false});
    controller.scannedDataStream.listen((barcode) async => {
          byId = {
            "ProductNumbers": ["${barcode.code}"]
          },
          if (!isDone)
            {
              setState(() => {
                    isDone = true,
                  }),
              controller.pauseCamera(),
              await ApiService.getFavorites(user.email.value).then((value) => {
                    if (value[0] == "200")
                      {
                        setState(() {
                          favs = value[1];
                        })
                      }
                  }),
              await ApiService.getProductById(byId).then((value) => {
                    if (value[0] == '200')
                      {
                        // Navigator.pushNamed(context, "/DetailsPage",
                        //     arguments: args),
                        if (favs.length == 0)
                          {
                            args = {
                              "name": value[1][0].Name,
                              "brand": value[1][0].Brand,
                              "description": value[1][0].Description,
                              "photo": value[1][0].Image,
                              "Number": value[1][0].Number,
                              "rate": "5.0",
                              "favorite": false,
                              "flag": false,
                              "scan": true,
                            }
                          }
                        else
                          {
                            for (int i = 0; i < favs.length; i++)
                              {
                                if (favs[i].Number == value[1][0].Number)
                                  {
                                    setState(() {
                                      args = {
                                        "name": value[1][0].Name,
                                        "brand": value[1][0].Brand,
                                        "description": value[1][0].Description,
                                        "photo": value[1][0].Image,
                                        "Number": value[1][0].Number,
                                        "rate": "5.0",
                                        "favorite": true,
                                        "flag": false,
                                        "scan": true,
                                      };
                                      i = favs.length - 1;
                                    }),
                                  }
                                else if (i == favs.length - 1)
                                  {
                                    args = {
                                      "name": value[1][0].Name,
                                      "brand": value[1][0].Brand,
                                      "description": value[1][0].Description,
                                      "photo": value[1][0].Image,
                                      "Number": value[1][0].Number,
                                      "rate": "5.0",
                                      "favorite": false,
                                      "flag": false,
                                      "scan": true,
                                    }
                                  }
                              },
                          },
                        Navigator.of(context)
                            .pushNamed('/DetailsPage', arguments: args)
                            .then((_) => setState(() {
                                  isDone = false;
                                }))
                      }
                    else if (value[0] == '400')
                      {
                        setState(
                            () => {isDone = false, controller.resumeCamera()}),
                        ErrorPopUp.errorPopUp(context, value[1]),
                      }
                  }),
            }
        });
  }
}
