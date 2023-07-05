import 'package:cigarKey/utils/fontSize.dart';
import 'package:flutter/material.dart';

class GeneralHeader extends StatelessWidget implements PreferredSizeWidget {
  GeneralHeader(this.height, this.title);
  final double height;
  final String title;
  Widget build(BuildContext context) {
    var widthSize = MediaQuery.of(context).size.width;
    var heightSize = MediaQuery.of(context).size.height;
    Color iconColor = Color(0xffFFFFFF);
    double iconSize = MediaQuery.of(context).size.width > 450 ? 30 : 18;

    return Padding(
      padding: EdgeInsets.only(
          top: heightSize * .035,
          left: widthSize * .05,
          right: widthSize * .05,
          bottom: height * .001),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              child: Row(children: [
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: iconColor,
                          size: iconSize,
                        )),
                  ),
                ]),
              ]),
            ),
            Expanded(
              child: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5, right: 10),
                    child: Text(
                      '$title',
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
              alignment: Alignment.topRight,
              child: Row(children: [
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 15, right: 10),
                    child: Image.asset(
                      'assets/logoBlanco.png',
                      scale: 30.9,
                    ),
                  ),
                ]),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height * 5);
}
