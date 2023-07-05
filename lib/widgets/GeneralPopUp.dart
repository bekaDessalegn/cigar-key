import 'package:cigarKey/utils/fontSize.dart';
import 'package:flutter/material.dart';

class GeneralPopUp {
  static generalPopUp(BuildContext context, String error) {
    final widthSize = MediaQuery.of(context).size.width;
    EdgeInsets paddingBtnReset =
        EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.width * .05, 0, 0);
    double buttonWidth = MediaQuery.of(context).size.width * .93;
    Color colorText = Color.fromRGBO(197, 169, 1, 1);
    Color colorBackground = Color.fromRGBO(107, 97, 100, 1);
    ButtonStyle buttonStyleRedonde = new ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
        backgroundColor: MaterialStateProperty.all<Color>(colorText));

    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              backgroundColor: colorBackground,
              content: Container(
                height: MediaQuery.of(context).size.height * 0.27,
                // width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 15),
                      child: Image.asset(
                        'assets/check.png',
                        scale: 1.5,
                      ),
                    ),
                    Text(
                      error,
                      textScaleFactor: Fonts().text(context),
                      style: TextStyle(
                        fontFamily: "Text",
                        color: Colors.white,
                        // fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: buttonWidth * 0.65,
                          height: widthSize * .15,
                          padding: paddingBtnReset,
                          child: ElevatedButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              style: buttonStyleRedonde,
                              child: Text(
                                "Return to login",
                                textScaleFactor: Fonts().textButton(context),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Text',
                                    fontWeight: FontWeight.w700),
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
