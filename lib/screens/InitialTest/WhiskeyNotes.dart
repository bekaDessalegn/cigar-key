import 'package:cigarKey/providers/provider.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:provider/provider.dart';

import '../../utils/fontSize.dart';

class WhiskeyNotes extends StatefulWidget {
  WhiskeyNotes({Key? key}) : super(key: key);

  @override
  State<WhiskeyNotes> createState() => _WhiskeyNotes();
}

enum Notes { Whiskey, Margarita, Martini, Moscato, NA }

class _WhiskeyNotes extends State<WhiskeyNotes> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    int? num;
    switch (provider.myTest) {
      case "beets":
        num = 0;
        break;
      case "pinea":
        num = 2;
        break;
      case "dates":
        num = 3;
        break;
      default:
    }
    Color colorText = Color.fromRGBO(197, 169, 1, 1);

    ButtonStyle buttonStyle = new ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        backgroundColor: MaterialStateProperty.all<Color>(colorText),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black));

    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              resultOptions[num!].photo,
              fit: BoxFit.fill,
            ),
            color: Colors.black,
          ),
          Container(
            color: Color.fromRGBO(0, 0, 0, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .9,
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height * .1, 0, 0)),
                SizedBox(
                  // height: MediaQuery.of(context).size.height * .2,
                  child: Text(
                    'Cocktail \n Suggestion',
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
                      top: MediaQuery.of(context).size.height * .1,
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
                            resultOptions[num].title,
                            textScaleFactor: Fonts().textTitle(context),
                            style: TextStyle(
                                // fontSize:
                                // MediaQuery.of(context).size.height * .055,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
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
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .06,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/TabBar');
                  },
                  child: Text(
                    'Go To Home',
                    textScaleFactor: Fonts().textButton(context),
                    style: TextStyle(
                      fontFamily: 'Text',
                      fontWeight: FontWeight.bold,
                      // fontSize: MediaQuery.of(context).size.height * .02
                    ),
                  ),
                  style: buttonStyle,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Result {
  final String title;
  final String photo;

  Result(this.title, this.photo);
}

List<Result> resultOptions = [
  new Result('Pina Colada / \n Margarita', 'assets/pina.png'),
  new Result('Whiskey / \n Bourbon / \n IPA', 'assets/bourbon.png'),
  new Result('Martini / \n Red Wine / \n Chardonnay', 'assets/martini.png'),
  new Result('Old Fashion / \n Moscato / \n Cider', 'assets/oldFashion.png'),
];
