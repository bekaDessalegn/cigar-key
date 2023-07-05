import 'package:flutter/material.dart';

import '../../utils/fontSize.dart';
import '../../widgets/GeneralHeader.dart';

class ContactUsPage extends StatefulWidget {
  ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Color.fromRGBO(12, 10, 10, 1),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              GeneralHeader(
                  MediaQuery.of(context).size.height * .2, "All Products"),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.call,
                            size: MediaQuery.of(context).size.width * .3,
                            color: Colors.grey.shade800),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .05,
                              bottom: MediaQuery.of(context).size.height * .02),
                          child: Text(
                            'Please, contact us',
                            textAlign: TextAlign.center,
                            textScaleFactor: Fonts().text(context),
                            style: TextStyle(
                                // color: Color.fromRGBO(107, 97, 100, 1),
                                color: Colors.white,
                                fontFamily: 'Title'),
                            //rgba(107, 97, 100, 1)
                          ),
                        ),
                        Text(
                          '55 1234 5678',
                          textAlign: TextAlign.center,
                          textScaleFactor: Fonts().text(context),
                          style: TextStyle(
                              // color: Color.fromRGBO(107, 97, 100, 1),
                              color: Colors.white,
                              fontFamily: 'Title'),
                          //rgba(107, 97, 100, 1)
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    ));
  }
}
