import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/userController.dart';
import '../../utils/fontSize.dart';

class ProfileResult extends StatefulWidget {
  ProfileResult({Key? key}) : super(key: key);

  @override
  State<ProfileResult> createState() => _ProfileResultState();
}

class _ProfileResultState extends State<ProfileResult> {
  UserController user = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    Color colorText = Color.fromRGBO(197, 169, 1, 1);
    final double screenScale = MediaQuery.of(context).size.width > 450 ? .7 : 1;
    ButtonStyle buttonStyle = new ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
        backgroundColor: MaterialStateProperty.all<Color>(colorText),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black));

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/result.png',
              fit: BoxFit.fitWidth,
            ),
            color: Colors.black,
          ),
          Container(
            color: Color.fromRGBO(0, 0, 0, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .9,
            child: (Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // height: MediaQuery.of(context).size.height * .2,
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height * .04, 0, 0)),
                Image.asset(
                  'assets/step6.png',
                  scale: screenScale,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, 0, 0, MediaQuery.of(context).size.height * .03),
                  child: Text(
                    'Profile Result',
                    textScaleFactor: Fonts().textTitle(context),
                    style: TextStyle(
                      fontFamily: 'Title',
                      color: Colors.white,
                      // fontSize: MediaQuery.of(context).size.height * .04
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .05,
                      bottom: MediaQuery.of(context).size.height * .01,
                      left: MediaQuery.of(context).size.width * .1,
                      right: MediaQuery.of(context).size.width * .1,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .4,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        color: Color.fromRGBO(217, 217, 217, 0.2),
                        child: Center(
                          child: Text(
                            '${user.rank.value}',
                            textScaleFactor: Fonts().textTitle(context),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: (Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .5,
                        height: MediaQuery.of(context).size.height * .07,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(context, '/TabBar');
                          },
                          child: Text(
                            'Go To Home',
                            textScaleFactor: Fonts().textButton(context),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Text',
                              // fontSize:
                              // MediaQuery.of(context).size.height * .02
                            ),
                          ),
                          style: buttonStyle,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * .025),
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/WhiskeyTest');
                            },
                            child: Text(
                              'View cocktail suggestion',
                              textScaleFactor: Fonts().textButton(context),
                              style: TextStyle(
                                  color: Colors.white,
                                  // fontSize:
                                  // MediaQuery.of(context).size.height * .02,
                                  fontFamily: 'Text',
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  )),
                )
              ],
            )),
          ),
        ],
      ),
    );
  }
}
