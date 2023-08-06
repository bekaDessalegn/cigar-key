import 'dart:async';
import 'package:cigarKey/screens/Login/LoginPage.dart';
import 'package:cigarKey/service/ApiService.dart';
import 'package:cigarKey/utils/fontSize.dart';
import 'package:cigarKey/utils/userPreferences.dart';
import 'package:cigarKey/widgets/ErrorPopup.dart';
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

  final userPreferences = UserPreferences();

  Timer? timer;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await checklSesion();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  checklSesion() async {
    timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      await goLogin();
    });
  }

  Future goLogin() async {
    await userPreferences.readLogin().then((value) async {
      if(value == null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
              (Route<dynamic> route) => false,
        );
      } else {
        final email = await userPreferences.getEmail();
        await ApiService.getProfile({"Email":email})
            .then((value) async {

          return {

            if (value[0] == '200')
              {
                setState(() {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/TabBar',
                        (Route<dynamic> route) => false,
                  );
                }),
              }
            else
              {
                await userPreferences.clearEmail(),
                await userPreferences.signout(),
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false,
                )
              }
          };
        });
      }
    });
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
