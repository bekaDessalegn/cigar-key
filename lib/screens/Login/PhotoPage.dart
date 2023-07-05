import 'dart:io';

import 'package:cigarKey/controllers/userController.dart';
import 'package:cigarKey/service/ApiService.dart';
import 'package:cigarKey/utils/fontSize.dart';
import 'package:cigarKey/widgets/ErrorPopup.dart';
import 'package:cigarKey/widgets/GeneralHeader.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../providers/provider.dart';

class PhotoPage extends StatefulWidget {
  PhotoPage({Key? key}) : super(key: key);

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  XFile? image = XFile('');
  bool photo = false;
  UserController user = Get.put(UserController());
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final ImagePicker picker = ImagePicker();
  ButtonStyle buttonStyleError = ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(Color.fromRGBO(67, 76, 87, 1)),
      shadowColor:
          MaterialStateProperty.all<Color>(Color.fromRGBO(67, 76, 87, 1)));

  Future takeAPicture() async {
    image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    if (image == null) {
    } else {
      setState(() {
        photo = true;
      });
    }
  }

  Future selectAPicture() async {
    image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (image == null) {
    } else {
      setState(() {
        photo = true;
      });
    }
  }

  Future imageSource(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoDialog(
          context: context,
          builder: (context) =>
              Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                CupertinoActionSheet(
                  actions: [
                    CupertinoActionSheetAction(
                        child: Text(
                          'Camera',
                          textScaleFactor: Fonts().textSmall(context),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(takeAPicture());
                        }),
                    CupertinoActionSheetAction(
                      child: Text(
                        'Gallery',
                        textScaleFactor: Fonts().textSmall(context),
                      ),
                      onPressed: () =>
                          Navigator.of(context).pop(selectAPicture()),
                    )
                  ],
                ),
              ]));
    }
    if (Platform.isAndroid) {
      await Permission.storage.request();
      await Permission.camera.request();
      var storage = await Permission.storage.status;
      var camera = await Permission.camera.status;
      if (storage.isGranted && camera.isGranted) {
        return showModalBottomSheet(
            context: context,
            builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text(
                        'Camera',
                        textScaleFactor: Fonts().textSmall(context),
                      ),
                      onTap: () {
                        Navigator.of(context).pop(takeAPicture());
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.image),
                      title: Text(
                        'Gallery',
                        textScaleFactor: Fonts().textSmall(context),
                      ),
                      onTap: () => Navigator.of(context).pop(selectAPicture()),
                    )
                  ],
                ));
      } else {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(
                    "Alert on permissions denied",
                    textScaleFactor: Fonts().text(context),
                  ),
                  content: Text(
                    "Please allow the app access the camera and gallery.",
                    textScaleFactor: Fonts().textSmall(context),
                  ),
                  actions: [
                    ElevatedButton(
                        style: buttonStyleError,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Accept",
                          textScaleFactor: Fonts().textButton(context),
                          style: TextStyle(
                            fontFamily: "Bold",
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width > 450
                                ? MediaQuery.of(context).size.width > 700
                                    ? 35
                                    : 25
                                : 16,
                          ),
                        )),
                  ],
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var userData = {};
    Color colorText = Color.fromRGBO(197, 169, 1, 1);
    double buttonWidth = MediaQuery.of(context).size.width * .93;
    var provider = Provider.of<MyProvider>(context);
    var widthSize = MediaQuery.of(context).size.width;
    var heightSize = MediaQuery.of(context).size.height;
    EdgeInsets paddingBtnImage =
        EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.width * .06, 0, 0);
    ButtonStyle buttonStylePhoto = new ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
        backgroundColor:
            MaterialStateProperty.all<Color>(Color.fromRGBO(0, 0, 0, 0.5)));

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
              child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/fondoCigarkey.png',
              fit: BoxFit.fill,
            ),
          )),
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  // GeneralHeader(MediaQuery.of(context).size.height, "photo"),
                  Padding(
                    padding: EdgeInsets.only(
                        top: heightSize * .035, right: widthSize * 0.05),
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
                                  'Photo',
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: widthSize * .01),
                    child: photo
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(150),
                            child: Image.file(
                              File(image!.path),
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ))
                        : Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 200,
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: heightSize * .02, bottom: heightSize * .1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: buttonWidth * 0.85,
                          height: heightSize * .11,
                          padding: paddingBtnImage,
                          child: ElevatedButton(
                              onPressed: () async {
                                imageSource(context);
                              },
                              style: buttonStylePhoto,
                              child: Text(
                                "Upload profile photo",
                                textScaleFactor: Fonts().text(context),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Text',
                                    fontSize: heightSize * .02,
                                    fontWeight: FontWeight.w700),
                              )),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: buttonWidth * 0.85,
                        height: heightSize * .06,
                        // padding: paddingBtnImage,
                        child: RoundedLoadingButton(
                            borderRadius: 100,
                            color: colorText,
                            width: buttonWidth * 0.85,
                            successColor: colorText,
                            controller: _btnController,
                            onPressed: () async {
                              try {
                                ApiService.uploadProfileImage(
                                        user.email.value, image)
                                    .then((value) => {
                                          if (value[0] == "200")
                                            {
                                              _btnController.success(),
                                              Navigator.pop(context),
                                              Navigator.popAndPushNamed(
                                                  context, '/StartTest'),
                                              provider.back = false,
                                            }
                                          else
                                            {
                                              _btnController.reset(),
                                              ErrorPopUp.errorPopUp(
                                                  context, "Ocurred an error")
                                            }
                                        });
                              } catch (e) {
                                _btnController.reset();
                                ErrorPopUp.errorPopUp(
                                    context, "Ocurred an error");
                              }
                            },
                            child: Text(
                              "Next",
                              textScaleFactor: Fonts().textButton(context),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Text',
                                  fontSize: heightSize * .02,
                                  fontWeight: FontWeight.w700),
                            )),
                      )
                    ],
                  ),
                  Container(
                    width: buttonWidth * 0.85,
                    height: heightSize * .1,
                    // padding: paddingBtnImage,
                    child: TextButton(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/StartTest');
                          provider.back = false;
                        },
                        style: ButtonStyle(),
                        child: Text(
                          "Skip",
                          textScaleFactor: Fonts().textButton(context),
                          style: TextStyle(
                              color: colorText,
                              fontFamily: 'Text',
                              fontSize: heightSize * .02,
                              fontWeight: FontWeight.w700),
                        )),
                  ),

                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, heightSize * .01)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
