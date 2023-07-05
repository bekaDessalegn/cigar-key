import 'package:cigarKey/utils/fontSize.dart';
import 'package:flutter/material.dart';
import 'package:cigarKey/widgets/GeneralHeader.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;
    final widthSize = MediaQuery.of(context).size.width;
    Color colorBackground = Color.fromRGBO(34, 30, 31, 0.8);

    final _oldPassController = TextEditingController();
    final _newPassController = TextEditingController();
    final _confirmPassController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(children: [
          Container(
            child: GeneralHeader(
                MediaQuery.of(context).size.height, "Change \n Password"),
          ),
          Flexible(
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: widthSize * .1, vertical: heightSize * .05),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: heightSize * .03),
                    child: TextFormField(
                      obscureText: true,
                      textAlign: TextAlign.justify,
                      cursorColor: Colors.white,
                      style: TextStyle(
                          color: Color.fromRGBO(197, 169, 1, 1),
                          fontFamily: 'Text',
                          fontSize:
                              14 / MediaQuery.of(context).textScaleFactor),
                      controller: _oldPassController,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: heightSize * .03,
                            horizontal: widthSize * .05),
                        fillColor: colorBackground,
                        labelStyle: TextStyle(
                          color: Colors.grey[400],
                          height: 14 / MediaQuery.of(context).textScaleFactor,
                          fontFamily: 'Text',
                        ),
                        labelText: 'Old password',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: heightSize * .03),
                    child: TextFormField(
                      obscureText: true,
                      textAlign: TextAlign.justify,
                      cursorColor: Colors.white,
                      style: TextStyle(
                          color: Color.fromRGBO(197, 169, 1, 1),
                          fontFamily: 'Text',
                          fontSize:
                              14 / MediaQuery.of(context).textScaleFactor),
                      controller: _newPassController,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: heightSize * .03,
                            horizontal: widthSize * .05),
                        fillColor: colorBackground,
                        labelStyle: TextStyle(
                          color: Colors.grey[400],
                          height: 14 / MediaQuery.of(context).textScaleFactor,
                          fontFamily: 'Text',
                        ),
                        labelText: 'New password',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: heightSize * .1),
                    child: TextFormField(
                      obscureText: true,
                      textAlign: TextAlign.justify,
                      cursorColor: Colors.white,
                      style: TextStyle(
                          color: Color.fromRGBO(197, 169, 1, 1),
                          fontFamily: 'Text',
                          fontSize:
                              14 / MediaQuery.of(context).textScaleFactor),
                      controller: _confirmPassController,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: heightSize * .03,
                            horizontal: widthSize * .05),
                        fillColor: colorBackground,
                        labelStyle: TextStyle(
                          color: Colors.grey[400],
                          height: 14 / MediaQuery.of(context).textScaleFactor,
                          fontFamily: 'Text',
                        ),
                        labelText: 'Confirm password',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: heightSize * .02),
                    child: Container(
                      width: widthSize,
                      height: heightSize * .06,
                      child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                      builder: (context, StateSetter setState) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      backgroundColor:
                                          Color.fromRGBO(34, 30, 31, 1),
                                      content: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.27,
                                        // width: MediaQuery.of(context).size.width,
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: InkWell(
                                                onTap: () {
                                                  // Navigator.pop(context);
                                                  Navigator.popUntil(
                                                      context,
                                                      ModalRoute.withName(
                                                          '/EditProfile'));
                                                },
                                                child: Icon(
                                                  Icons.close_outlined,
                                                  color: Colors.white,
                                                  size: heightSize * .03,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                  bottom: heightSize * .03,
                                                ),
                                                child: Icon(
                                                  Icons
                                                      .check_circle_outline_rounded,
                                                  color: Color.fromRGBO(
                                                      197, 169, 1, 1),
                                                  size: heightSize * .1,
                                                )),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                bottom: heightSize * .02,
                                              ),
                                              child: Text(
                                                'Modified password successfully',
                                                textScaleFactor:
                                                    Fonts().text(context),
                                                style: TextStyle(
                                                  fontFamily: "Text",
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                });

                            // Navigator.pop(context);
                          },
                          child: Text(
                            'Submit',
                            textScaleFactor: Fonts().textButton(context),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromRGBO(197, 169, 1, 1)),
                              foregroundColor: MaterialStateProperty.all(
                                Colors.black,
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      side: BorderSide(
                                          style: BorderStyle.none))))),
                    ),
                  ),
                ],
              ),
            )),
          ),
        ]),
      ),
    );
  }
}
