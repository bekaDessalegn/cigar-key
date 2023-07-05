import 'package:cigarKey/utils/fontSize.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/provider.dart';

class NatureNotes extends StatefulWidget {
  NatureNotes({Key? key}) : super(key: key);

  @override
  State<NatureNotes> createState() => _NatureNotes();
}

enum Notes { Cayenne, BlackPapper, GreenPapper, Cinnamon, NA }

class _NatureNotes extends State<NatureNotes> {
  @override
  Widget build(BuildContext context) {
    Color colorText = Color.fromRGBO(197, 169, 1, 1);
    final double screenScale = MediaQuery.of(context).size.width > 450 ? .7 : 1;
    final args = ModalRoute.of(context)?.settings.arguments as List;
    var provider = Provider.of<MyProvider>(context);

    List<dynamic> items = [];

    for (int i = 0; i < args.length; i++) {
      if (args[i]['Type'] == "Nature/Earthy Notes") {
        setState(() {
          items.add(args[i]);
        });
      }
    }

    ButtonStyle buttonStyle = new ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        backgroundColor: MaterialStateProperty.all<Color>(colorText),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black));

    ButtonStyle buttonBackStyle = new ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side:
              BorderSide(style: BorderStyle.solid, width: 1, color: colorText),
        )),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        foregroundColor: MaterialStateProperty.all<Color>(colorText));

    void tapValue(String value) {
      provider.natureValue = value;
      Navigator.pushNamed(context, '/SweetTest', arguments: args);
      // _notes = value;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/Nature.png',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            color: Color.fromRGBO(0, 0, 0, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .9,
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height * .07, 0, 0)),
                Image.asset(
                  'assets/step2.png',
                  scale: screenScale,
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, 0, 0, MediaQuery.of(context).size.height * .03)),
                SizedBox(
                  // height: MediaQuery.of(context).size.height * .2,
                  child: Text(
                    'Nature / earthy \n preference?',
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
                      top: MediaQuery.of(context).size.height * .02,
                      bottom: MediaQuery.of(context).size.height * .02,
                      left: MediaQuery.of(context).size.width * .1,
                      right: MediaQuery.of(context).size.width * .1,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .08,
                      decoration: BoxDecoration(
                          color:
                              provider.myNatureValue == items[0]['PreferenceId']
                                  ? Color.fromRGBO(106, 4, 5, 0.8)
                                  : Color.fromRGBO(0, 0, 0, 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        hoverColor: Color.fromARGB(204, 230, 65, 114),
                        onTap: () {
                          setState(() {
                            tapValue(items[0]['PreferenceId']);
                          });
                        },
                        child: ListTile(
                          textColor: Colors.white,
                          title: Text(
                            items.length > 0 ? items[0]['Name'] : '',
                            textScaleFactor: Fonts().textSmall(context),
                          ),
                          leading: Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white),
                            activeColor: Colors.white,
                            value: provider.myNatureValue,
                            groupValue: items[0]['PreferenceId'],
                            onChanged: (value) {
                              setState(() {
                                tapValue(items[0]['PreferenceId']);
                              });
                            },
                          ),
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * .02,
                      left: MediaQuery.of(context).size.width * .1,
                      right: MediaQuery.of(context).size.width * .1,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .08,
                      decoration: BoxDecoration(
                          color:
                              provider.myNatureValue == items[1]['PreferenceId']
                                  ? Color.fromRGBO(106, 4, 5, 0.8)
                                  : Color.fromRGBO(0, 0, 0, 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        hoverColor: Color.fromARGB(204, 230, 65, 114),
                        onTap: () {
                          setState(() {
                            tapValue(items[1]['PreferenceId']);
                          });
                        },
                        child: ListTile(
                          textColor: Colors.white,
                          title: Text(
                            items.length > 0 ? items[1]['Name'] : '',
                            textScaleFactor: Fonts().textSmall(context),
                          ),
                          leading: Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white),
                            activeColor: Colors.white,
                            value: provider.myNatureValue,
                            groupValue: items[1]['PreferenceId'],
                            onChanged: (value) {
                              setState(() {
                                tapValue(items[1]['PreferenceId']);
                              });
                            },
                          ),
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .1,
                      right: MediaQuery.of(context).size.width * .1,
                      bottom: MediaQuery.of(context).size.height * .02,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .08,
                      decoration: BoxDecoration(
                          color:
                              provider.myNatureValue == items[2]['PreferenceId']
                                  ? Color.fromRGBO(106, 4, 5, 0.8)
                                  : Color.fromRGBO(0, 0, 0, 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        hoverColor: Color.fromARGB(204, 230, 65, 114),
                        onTap: () {
                          setState(() {
                            tapValue(items[2]['PreferenceId']);
                          });
                        },
                        child: ListTile(
                          textColor: Colors.white,
                          title: Text(
                            items.length > 0 ? items[2]['Name'] : '',
                            textScaleFactor: Fonts().textSmall(context),
                          ),
                          leading: Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white),
                            activeColor: Colors.white,
                            value: provider.myNatureValue,
                            groupValue: items[2]['PreferenceId'],
                            onChanged: (value) {
                              setState(() {
                                tapValue(items[2]['PreferenceId']);
                              });
                            },
                          ),
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .1,
                      right: MediaQuery.of(context).size.width * .1,
                      bottom: MediaQuery.of(context).size.height * .02,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .08,
                      decoration: BoxDecoration(
                          color:
                              provider.myNatureValue == items[3]['PreferenceId']
                                  ? Color.fromRGBO(106, 4, 5, 0.8)
                                  : Color.fromRGBO(0, 0, 0, 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        hoverColor: Color.fromARGB(204, 230, 65, 114),
                        onTap: () {
                          setState(() {
                            tapValue(items[3]['PreferenceId']);
                          });
                        },
                        child: ListTile(
                          textColor: Colors.white,
                          title: Text(
                            items.length > 0 ? items[3]['Name'] : '',
                            textScaleFactor: Fonts().textSmall(context),
                          ),
                          leading: Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white),
                            activeColor: Colors.white,
                            value: provider.myNatureValue,
                            groupValue: items[3]['PreferenceId'],
                            onChanged: (value) {
                              setState(() {
                                tapValue(items[3]['PreferenceId']);
                              });
                            },
                          ),
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .1,
                      right: MediaQuery.of(context).size.width * .1,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .08,
                      decoration: BoxDecoration(
                          color:
                              provider.myNatureValue == items[4]['PreferenceId']
                                  ? Color.fromRGBO(106, 4, 5, 0.8)
                                  : Color.fromRGBO(0, 0, 0, 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        hoverColor: Color.fromARGB(204, 230, 65, 114),
                        onTap: () {
                          setState(() {
                            tapValue(items[4]['PreferenceId']);
                          });
                        },
                        child: ListTile(
                          textColor: Colors.white,
                          title: Text(
                            items.length > 0 ? items[4]['Name'] : '',
                            textScaleFactor: Fonts().textSmall(context),
                          ),
                          leading: Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white),
                            activeColor: Colors.white,
                            value: provider.myNatureValue,
                            groupValue: items[4]['PreferenceId'],
                            onChanged: (value) {
                              setState(() {
                                tapValue(items[4]['PreferenceId']);
                              });
                            },
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * .12,
                right: MediaQuery.of(context).size.width * .12,
                bottom: MediaQuery.of(context).size.height * .05),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .76,
                    height: MediaQuery.of(context).size.height * .06,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Back',
                        textScaleFactor: Fonts().textButton(context),
                        style: TextStyle(
                            // fontSize: MediaQuery.of(context).size.height * .02,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Text'),
                      ),
                      style: buttonBackStyle,
                    ),
                  ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width * .35,
                  //   height: MediaQuery.of(context).size.height * .06,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, '/SweetTest');
                  //     },
                  //     child: Text(
                  //       'Next Step',
                  //       style: TextStyle(
                  //           fontSize: MediaQuery.of(context).size.height * .02,
                  //           fontWeight: FontWeight.bold,
                  //           fontFamily: 'Text'),
                  //     ),
                  //     style: buttonStyle,
                  //   ),
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
