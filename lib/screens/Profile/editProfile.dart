import 'dart:io';

import 'package:cigarKey/controllers/userController.dart';
import 'package:cigarKey/service/ApiService.dart';
import 'package:cigarKey/utils/fontSize.dart';
import 'package:cigarKey/widgets/ErrorPopup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cigarKey/widgets/GeneralHeader.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  UserController user = Get.put(UserController());

  XFile? image = XFile('');
  String? gender;
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final ImagePicker picker = ImagePicker();
  bool photo = false;
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
      ApiService.uploadProfileImage(user.email.value, image).then((value) => {
            if (value[0] == "200") {print("Upload Succesfully")}
          });
      setState(() {
        photo = true;
      });
    }
  }

  Future selectAPicture(context) async {
    image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (image == null) {
    } else {
      ApiService.uploadProfileImage(user.email.value, image).then((value) => {
            if (value[0] == "200") {print("Upload Succesfully")}
          });
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
                          textScaleFactor: Fonts().text(context),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(takeAPicture());
                        }),
                    CupertinoActionSheetAction(
                      child: Text('Gallery',
                          textScaleFactor: Fonts().text(context)),
                      onPressed: () =>
                          Navigator.of(context).pop(selectAPicture(context)),
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
                        textScaleFactor: Fonts().text(context),
                      ),
                      onTap: () {
                        Navigator.of(context).pop(takeAPicture());
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.image),
                      title: Text(
                        'Galery',
                        textScaleFactor: Fonts().text(context),
                      ),
                      onTap: () =>
                          Navigator.of(context).pop(selectAPicture(context)),
                    )
                  ],
                ));
      } else {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(
                    "Alert on permissions denied",
                    textScaleFactor: Fonts().textTitle(context),
                  ),
                  content: Text(
                      "Please allow the app access the camera and gallery.",
                      textScaleFactor: Fonts().text(context)),
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
    Color colorText = Color.fromRGBO(197, 169, 1, 1);
    var userData = {};
    print(gender);
    final heightSize = MediaQuery.of(context).size.height;
    final widthSize = MediaQuery.of(context).size.width;
    Color colorBackground = Color.fromRGBO(34, 30, 31, 0.8);

    final _nameController = TextEditingController(text: user.name.value);
    final _lastNameController =
        TextEditingController(text: user.lastName.value);
    final _emailController = TextEditingController(text: user.email.value);
    final _phoneController = TextEditingController(text: user.phone.value);
    final _zipController = TextEditingController(text: user.zip.value);
    final _genderController = TextEditingController(text: user.gender.value);

    String _profileImage = user.image.value;

    // List<DropdownMenuItem<String>> _gender = [
    //   DropdownMenuItem(
    //       child: Text("Male",
    //           style: TextStyle(
    //               fontSize: 14 / MediaQuery.of(context).textScaleFactor)
    //           // textScaleFactor: Fonts().textButton(context),
    //           ),
    //       value: 'M'),
    //   DropdownMenuItem(
    //       child: Text("Female",
    //           style: TextStyle(
    //               fontSize: 14 / MediaQuery.of(context).textScaleFactor)
    //           // textScaleFactor: Fonts().textButton(context),
    //           ),
    //       value: 'F'),
    // ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Container(
              child: GeneralHeader(
                  MediaQuery.of(context).size.height, "Edit Profile"),
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: widthSize * .1),
                  child: Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: heightSize * .05),
                          child: photo
                              ? Stack(children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(150),
                                      child: Image.file(
                                        File(image!.path),
                                        width: widthSize * .4,
                                        height: widthSize * .4,
                                        fit: BoxFit.cover,
                                      )),
                                  Positioned(
                                    top: widthSize * .3,
                                    right: widthSize * .001,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                              CircleBorder()),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromRGBO(
                                                      201, 151, 23, 1)),
                                        ),
                                        onPressed: () {
                                          imageSource(context);
                                        },
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(heightSize * .015),
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            color: Colors.white,
                                            size: heightSize * .03,
                                          ),
                                        )),
                                  ),
                                ])
                              : CircleAvatar(
                                  backgroundColor: Colors.black,
                                  backgroundImage: NetworkImage(_profileImage
                                              .length !=
                                          0
                                      ? _profileImage
                                      : 'https://cdn5.vectorstock.com/i/thumb-large/45/59/profile-photo-placeholder-icon-design-in-gray-vector-37114559.jpg'),
                                  radius: widthSize * .2,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                              CircleBorder()),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromRGBO(
                                                      201, 151, 23, 1)),
                                        ),
                                        onPressed: () {
                                          imageSource(context);
                                          //  ApiService.uploadProfileImage(
                                          //                 user['Email'], image)
                                          //             .then((value) => {
                                          //                   if (value[0] == "200")
                                          //                     {
                                          //                       _btnController
                                          //                           .success(),
                                          //                       Navigator.pop(
                                          //                           context),
                                          //                       Navigator
                                          //                           .popAndPushNamed(
                                          //                               context,
                                          //                               '/StartTest'),
                                          //                     }
                                          //                 }),
                                        },
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(heightSize * .015),
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            color: Colors.white,
                                            size: heightSize * .03,
                                          ),
                                        )),
                                  ),
                                ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: heightSize * .025),
                        child: TextFormField(
                          textAlign: TextAlign.justify,
                          cursorColor: Colors.white,
                          style: TextStyle(
                              color: Color.fromRGBO(197, 169, 1, 1),
                              fontFamily: 'Text',
                              fontSize:
                                  14 / MediaQuery.of(context).textScaleFactor),
                          controller: _nameController,
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: heightSize * .029,
                                horizontal: widthSize * .05),
                            fillColor: colorBackground,
                            labelStyle: TextStyle(
                              color: Colors.grey[400],
                              height: 5,
                              fontFamily: 'Text',
                            ),
                            labelText: 'Name',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: heightSize * .025),
                        child: TextFormField(
                          textAlign: TextAlign.justify,
                          cursorColor: Colors.white,
                          style: TextStyle(
                              color: Color.fromRGBO(197, 169, 1, 1),
                              fontFamily: 'Text',
                              fontSize:
                                  14 / MediaQuery.of(context).textScaleFactor),
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: heightSize * .029,
                                horizontal: widthSize * .05),
                            fillColor: colorBackground,
                            labelStyle: TextStyle(
                              color: Colors.grey[400],
                              height: 5,
                              fontFamily: 'Text',
                            ),
                            labelText: 'Last Name',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: heightSize * .025),
                        child: TextFormField(
                          textAlign: TextAlign.justify,
                          cursorColor: Colors.white,
                          style: TextStyle(
                              color: Color.fromRGBO(197, 169, 1, 1),
                              fontFamily: 'Text',
                              fontSize:
                                  14 / MediaQuery.of(context).textScaleFactor),
                          controller: _emailController,
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: heightSize * .029,
                                horizontal: widthSize * .05),
                            fillColor: colorBackground,
                            labelStyle: TextStyle(
                              color: Colors.grey[400],
                              height: 5,
                              fontFamily: 'Text',
                            ),
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: heightSize * .025),
                        child: TextFormField(
                          textAlign: TextAlign.justify,
                          cursorColor: Colors.white,
                          style: TextStyle(
                              color: Color.fromRGBO(197, 169, 1, 1),
                              fontFamily: 'Text',
                              fontSize:
                                  14 / MediaQuery.of(context).textScaleFactor),
                          controller: _phoneController,
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: heightSize * .029,
                                horizontal: widthSize * .05),
                            fillColor: colorBackground,
                            labelStyle: TextStyle(
                              color: Colors.grey[400],
                              height: 5,
                              fontFamily: 'Text',
                            ),
                            labelText: 'Phone number (Optional)',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: heightSize * .025),
                        child: TextFormField(
                          textAlign: TextAlign.justify,
                          cursorColor: Colors.white,
                          style: TextStyle(
                              color: Color.fromRGBO(197, 169, 1, 1),
                              fontFamily: 'Text',
                              fontSize:
                                  14 / MediaQuery.of(context).textScaleFactor),
                          controller: _genderController,
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: heightSize * .029,
                                horizontal: widthSize * .05),
                            fillColor: colorBackground,
                            labelStyle: TextStyle(
                              color: Colors.grey[400],
                              height: 5,
                              fontFamily: 'Text',
                            ),
                            labelText: 'Gender',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: heightSize * .025),
                        child: TextFormField(
                          textAlign: TextAlign.justify,
                          cursorColor: Colors.white,
                          style: TextStyle(
                              color: Color.fromRGBO(197, 169, 1, 1),
                              fontFamily: 'Text',
                              fontSize:
                                  14 / MediaQuery.of(context).textScaleFactor),
                          controller: _zipController,
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: heightSize * .029,
                                horizontal: widthSize * .05),
                            fillColor: colorBackground,
                            labelStyle: TextStyle(
                              color: Colors.grey[400],
                              height: 5,
                              fontFamily: 'Text',
                            ),
                            labelText: 'Zip',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                      ),

                      // Padding(
                      //   padding: EdgeInsets.only(bottom: heightSize * .025),
                      //   child: Container(
                      //     width: widthSize,
                      //     height: heightSize * .065,
                      //     child: ElevatedButton(
                      //         onPressed: () {
                      //           Navigator.pushNamed(context, '/ChangePassword');
                      //         },
                      //         child: Text(
                      //           'Change Password',
                      //           textScaleFactor: Fonts().textButton(context),
                      //         ),
                      //         style: ButtonStyle(
                      //             backgroundColor:
                      //                 MaterialStateProperty.all(Colors.black),
                      //             foregroundColor: MaterialStateProperty.all(
                      //                 Color.fromRGBO(197, 169, 1, 1)),
                      //             shape: MaterialStateProperty.all(
                      //                 RoundedRectangleBorder(
                      //                     borderRadius:
                      //                         BorderRadius.circular(100),
                      //                     side: BorderSide(
                      //                         color: Color.fromRGBO(
                      //                             197, 169, 1, 1),
                      //                         width: 1))))),
                      //   ),
                      // ),

                      Padding(
                        padding: EdgeInsets.only(bottom: heightSize * .025),
                        child: Container(
                          width: widthSize,
                          height: heightSize * .065,
                          child: RoundedLoadingButton(
                            borderRadius: 100,
                            color: colorText,
                            width: widthSize,
                            height: heightSize * .065,
                            successColor: colorText,
                            controller: _btnController,
                            onPressed: () {
                              try {
                                userData = {
                                  "FirstName": _nameController.text,
                                  "LastName": _lastNameController.text,
                                  "Email": _emailController.text,
                                  "Gender": _genderController.text,
                                  "PhoneNumber": _phoneController.text,
                                  "ZipCode": _zipController.text,
                                };
                                ApiService.updateProfile(userData)
                                    .then((value) => {
                                          if (value[0] == "200")
                                            {
                                              Navigator.pop(context),
                                            }
                                          else
                                            {
                                              _btnController.reset(),
                                              ErrorPopUp.errorPopUp(
                                                  context, "${value[1]}")
                                            }
                                        });
                              } catch (e) {
                                _btnController.reset();
                                ErrorPopUp.errorPopUp(
                                    context, "Ocurred an error");
                              }
                            },
                            child: Text(
                              'Save',
                              textScaleFactor: Fonts().textButton(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
