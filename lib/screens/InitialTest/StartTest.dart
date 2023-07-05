import 'package:cigarKey/providers/provider.dart';
import 'package:cigarKey/service/ApiService.dart';
import 'package:cigarKey/utils/fontSize.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartTest extends StatefulWidget {
  StartTest({Key? key}) : super(key: key);

  @override
  State<StartTest> createState() => _StartTestState();
}

class _StartTestState extends State<StartTest> {
  List<dynamic> questionnaire = [];

  @override
  void initState() {
    final args = {"questionnaireTypes": []};
    ApiService.getQuestionnaire(args).then((response) => {
          if (response[0] == "200")
            {
              setState(() {
                questionnaire = response[1];
              })
            }
          else
            {print(response[0])}
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color colorText = Color.fromRGBO(197, 169, 1, 1);
    var provider = Provider.of<MyProvider>(context);

    ButtonStyle buttonStyle = new ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        backgroundColor: MaterialStateProperty.all<Color>(colorText),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black));
    Color iconColor = Color(0xffFFFFFF);
    double iconSize = MediaQuery.of(context).size.width > 450 ? 30 : 18;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/TasteElement.png',
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .1,
                  right: MediaQuery.of(context).size.width * .1,
                  bottom: MediaQuery.of(context).size.height * .05,
                  top: MediaQuery.of(context).size.height * .03,
                )),
                Row(
                  children: [
                    provider.myBack
                        ? Container(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .02,
                            ),
                            alignment: Alignment.bottomCenter,
                            child: Row(children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          color: iconColor,
                                          size: iconSize,
                                        )),
                                  ]),
                            ]),
                          )
                        : Container(),
                    Expanded(
                      child: Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 5,
                            ),
                            child: Text(
                              'Each cigar \n offers a unique \n flavor',
                              textScaleFactor: Fonts().textTitle(context),
                              style: TextStyle(
                                fontFamily: 'Title',
                                color: Colors.white,
                                // fontSize: MediaQuery.of(context).size.width * .06,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .1,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .05,
                    vertical: MediaQuery.of(context).size.height * .03,
                  ),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/CoffeeTest',
                                arguments: questionnaire);
                          },
                          child: Image(
                            image: AssetImage('assets/boton.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        // Center(
                        //   child: Image(
                        //     image: AssetImage('assets/boton.png'),
                        //     fit: BoxFit.fill,
                        //   ),
                        //   // child: ElevatedButton(
                        //   //   onPressed: () {
                        //   //     Navigator.pushNamed(context, '/CoffeeTest',
                        //   //         arguments: questionnaire);
                        //   //   },
                        //   //   child: Text(
                        //   //     'START',
                        //   //     textAlign: TextAlign.center,
                        //   //     textScaleFactor: Fonts().textStart(context),
                        //   //     style: TextStyle(
                        //   //       fontWeight: FontWeight.w900,
                        //   //       fontFamily: 'Text',
                        //   //       color: Colors.white,
                        //   //     ),
                        //   //   ),
                        //   //   style: ElevatedButton.styleFrom(
                        //   //       shape: const CircleBorder(),
                        //   //       primary: colorText,
                        //   //       fixedSize: Size(
                        //   //           MediaQuery.of(context).size.width,
                        //   //           MediaQuery.of(context).size.height < 600
                        //   //               ? MediaQuery.of(context).size.height *
                        //   //                   .245
                        //   //               : MediaQuery.of(context).size.height *
                        //   //                   .20)),
                        //   // ),
                        // )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .1,
                    right: MediaQuery.of(context).size.width * .1,
                    top: MediaQuery.of(context).size.height * .05,
                  ),
                  child: Text(
                    'Lets take a moment \n to explore your preferences',
                    textScaleFactor: Fonts().textSmall(context),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Title',
                      color: Colors.white,
                      // fontSize: MediaQuery.of(context).size.width * .04
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
