import 'dart:async';
import 'package:cigarKey/screens/Login/LoginPage.dart';
import 'package:cigarKey/utils/fontSize.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingBody(),
    );
  }
}

class LoadingBody extends StatefulWidget {
  @override
  State<LoadingBody> createState() => _LoadingBodyState();
}

class _LoadingBodyState extends State<LoadingBody> {
  Timer? timer;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checklSesion();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  checklSesion() async {
    timer = Timer.periodic(Duration(seconds: 4), (timer) {
      goLogin();
    });
  }

  goLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    double loadingSize = MediaQuery.of(context).size.width * .2;
    double iconSize = MediaQuery.of(context).size.width * .5;
    double paddingIcon = MediaQuery.of(context).size.width * .2;
    print(MediaQuery.of(context).size.width);
    print("Heighy ${MediaQuery.of(context).size.height}");
    TextStyle mainTextStyle = TextStyle(
        color: Colors.white,
        // fontSize: MediaQuery.of(context).size.width > 450 ? 22.0 : 15.0,
        fontFamily: 'Title',
        fontWeight: FontWeight.w100);
    TextStyle urlTextStyle = TextStyle(
      color: Colors.white,
      fontFamily: 'Title',
      // fontSize: MediaQuery.of(context).size.width > 450 ? 22.0 : 14.0,
    );
    TextStyle textCharuto = TextStyle(
      color: Colors.white,
      fontFamily: 'Title',
      // fontSize: MediaQuery.of(context).size.width > 450 ? 23.0 : 15.0,
    );

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/fondoCigarkey.png',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.only(bottom: paddingIcon),
                    width: iconSize,
                    height: iconSize + paddingIcon,
                    child: Image(
                      image: AssetImage('assets/logoCigarkey.png'),
                      fit: BoxFit.fitHeight,
                    )),
                Container(
                  width: loadingSize,
                  height: loadingSize,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: EdgeInsets.only(top: loadingSize * .5),
                      child: Text(
                        "An experience...",
                        style: mainTextStyle,
                        textScaleFactor: Fonts().text(context),
                      )),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: 'unlock your ', style: urlTextStyle),
                        TextSpan(text: 'charuto', style: textCharuto),
                      ],
                    ),
                    textScaleFactor: Fonts().text(context),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
