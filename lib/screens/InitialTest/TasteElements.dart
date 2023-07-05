import 'package:flutter/material.dart';

class TasteElements extends StatefulWidget {
  TasteElements({Key? key}) : super(key: key);

  @override
  State<TasteElements> createState() => _TasteElementsState();
}

class _TasteElementsState extends State<TasteElements> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
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
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).size.height * .15, 0, 0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Taste elements of cigars',
                      style: TextStyle(
                          fontFamily: 'Title',
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * .05),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
