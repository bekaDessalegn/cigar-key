import 'dart:io';

import 'package:cigarKey/service/ApiService.dart';
import 'package:cigarKey/utils/fontSize.dart';
import 'package:cigarKey/widgets/ErrorPopup.dart';
import 'package:cigarKey/widgets/GeneralHeader.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScanQRPageBody(),
    );
  }
}

class ScanQRPageBody extends StatefulWidget {
  @override
  State<ScanQRPageBody> createState() => _ScanQRPageBodyState();
}

class _ScanQRPageBodyState extends State<ScanQRPageBody> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  var byId = {};
  bool isDone = false;
  Barcode? barcode;
  QRViewController? controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    controller?.resumeCamera();
    var widthSize = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          QRView(
              key: qrKey,
              onQRViewCreated: onQRviewCreated,
              overlay: QrScannerOverlayShape(
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
                    'Scan the product with your camera and wait',
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
            top: 15,
            child: GeneralHeader(MediaQuery.of(context).size.height, "Scan"),
          ),
        ],
      ),
    );
  }

  void onQRviewCreated(QRViewController controller) {
    Map args = {};
    setState(() => this.controller = controller);
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
              await ApiService.getProductById(byId).then((value) => {
                    if (value[0] == '200')
                      {
                        setState(() {
                          args = {
                            "name": value[1][0].Name,
                            "brand": value[1][0].Brand,
                            "description": value[1][0].Description,
                            "photo": value[1][0].Image,
                            "rate": "5.0",
                            "favorite": false,
                          };
                        }),
                        Navigator.of(context)
                            .pushNamed('/PublicDetails', arguments: args)
                            .then((_) => setState(() {
                                  isDone = false;
                                }))
                      }
                    else if (value[0] == '400')
                      {
                        setState(
                            () => {isDone = false, controller.resumeCamera()}),
                        ErrorPopUp.errorPopUp(context, value[1])
                      }
                  }),
            }
        });
  }
}
