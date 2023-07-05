import 'package:cigarKey/utils/fontSize.dart';
import 'package:flutter/material.dart';

class ErrorPopUp {
  static errorPopUp(BuildContext context, String error) {
    final widthSize = MediaQuery.of(context).size.width;
    EdgeInsets paddingBtnReset =
        EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.width * .05, 0, 0);
    double buttonWidth = MediaQuery.of(context).size.width * .93;
    Color colorText = Color.fromRGBO(197, 169, 1, 1);
    Color colorBackground = Color.fromRGBO(34, 30, 31, 1);
    ButtonStyle buttonStyleError = new ButtonStyle(
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
              title: Icon(
                Icons.warning,
                size: MediaQuery.of(context).size.width > 450
                    ? MediaQuery.of(context).size.width > 700
                        ? 80
                        : 60
                    : MediaQuery.of(context).size.width > 390
                        ? 50
                        : 40,
                color: colorText,
              ),
              content: Text(
                error,
                textScaleFactor: Fonts().text(context),
                style: TextStyle(
                  fontFamily: "Text",
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width > 450
                      ? MediaQuery.of(context).size.width > 700
                          ? 40
                          : 19
                      : 18,
                ),
                textAlign: TextAlign.center,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: buttonStyleError,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Ok",
                            textScaleFactor: Fonts().textButton(context),
                            style: TextStyle(
                              fontFamily: "Bold",
                              color: Colors.black,
                              fontSize: MediaQuery.of(context).size.width > 450
                                  ? MediaQuery.of(context).size.width > 700
                                      ? 35
                                      : 20
                                  : 16,
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            );
          });
        });
  }
}
