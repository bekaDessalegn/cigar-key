import 'package:cigarKey/utils/fontSize.dart';
import 'package:cigarKey/widgets/GeneralHeader.dart';
import 'package:flutter/material.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({Key? key}) : super(key: key);

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  @override
  Widget build(BuildContext context) {
    List<Map> mildList = [
      {
        'brand': 'Chuchill',
        'name': 'Alec Bradley',
        'rate': '5.0',
        'photo': 'assets/cigar4.png'
      },
      {
        'brand': 'Grenadiers Claro',
        'name': 'Antonio y Cleopatra',
        'rate': '4.9',
        'photo': 'assets/cigar3.png'
      },
      {
        'brand': 'Chuchill',
        'name': 'Alec Bradley',
        'rate': '5.0',
        'photo': 'assets/cigar4.png'
      },
      {
        'brand': 'Grenadiers Claro',
        'name': 'Antonio y Cleopatra',
        'rate': '4.9',
        'photo': 'assets/cigar3.png'
      },
      {
        'brand': 'Chuchill',
        'name': 'Alec Bradley',
        'rate': '5.0',
        'photo': 'assets/cigar4.png'
      },
      {
        'brand': 'Grenadiers Claro',
        'name': 'Antonio y Cleopatra',
        'rate': '4.9',
        'photo': 'assets/cigar3.png'
      },
      {
        'brand': 'Chuchill',
        'name': 'Alec Bradley',
        'rate': '5.0',
        'photo': 'assets/cigar4.png'
      },
      {
        'brand': 'Grenadiers Claro',
        'name': 'Antonio y Cleopatra',
        'rate': '4.9',
        'photo': 'assets/cigar3.png'
      },
    ];
    var widthSize = MediaQuery.of(context).size.width;
    var heightSize = MediaQuery.of(context).size.height;
    Color colorText = Color.fromRGBO(201, 151, 23, 1);
    Color colorRed = Color.fromRGBO(156, 27, 23, 1);

    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: Container(
            color: Color.fromRGBO(12, 10, 10, 1),
            width: widthSize,
            height: heightSize,
          ),
        ),
        Container(
          width: widthSize,
          child: Column(children: [
            GeneralHeader(heightSize, "rewards"),
            Expanded(
              child: ListView.builder(
                  itemCount: mildList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/SuggestionsPage');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(228, 70, 66, 67),
                                      Color.fromRGBO(12, 10, 10, 1),
                                    ],
                                    stops: [0.0, 2.0],
                                    tileMode: TileMode.clamp),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(32.0),
                                ),
                              ),
                              padding: EdgeInsets.all(5),
                              child: Container(
                                padding: EdgeInsets.all(7),
                                child: Row(children: [
                                  Column(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(24),
                                        child: Image.asset(
                                          mildList[index]['photo'],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ]),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                mildList[index]['brand'],
                                                textScaleFactor:
                                                    Fonts().text(context),
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Text',
                                                  fontWeight: FontWeight.w700,
                                                  // fontSize: widthSize * .03
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 12.0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                mildList[index]['name'],
                                                textScaleFactor:
                                                    Fonts().text(context),
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      165, 151, 136, 1),
                                                  fontFamily: 'Text',
                                                  // fontSize: widthSize * .03
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        child: Text(
                                                          'Quality: 3',
                                                          textScaleFactor:
                                                              Fonts().textSmall(
                                                                  context),
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    165,
                                                                    151,
                                                                    136,
                                                                    1),
                                                            fontFamily: 'Text',
                                                            // fontSize:
                                                            //     widthSize *
                                                            //         .03
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        child: Text(
                                                          '10 Pts',
                                                          textScaleFactor:
                                                              Fonts().textSmall(
                                                                  context),
                                                          style: TextStyle(
                                                            color: colorText,
                                                            fontFamily: 'Text',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            // fontSize:
                                                            //     heightSize *
                                                            //         .025
                                                          ),
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]);
                  }),
            ),
            Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(34, 30, 31, 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          )),
                      width: widthSize,
                      height: heightSize * .108,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '40 Pts',
                            textScaleFactor: Fonts().text(context),
                            style: TextStyle(
                              color: colorText,
                              fontFamily: 'Text',
                              fontWeight: FontWeight.w700,
                              // fontSize: heightSize * .035
                            ),
                          ),
                          Container(
                            height: heightSize * .07,
                            width: widthSize * .25,
                            child: ElevatedButton(
                                child: Text(
                                  'Redeem',
                                  textScaleFactor: Fonts().textButton(context),
                                ),
                                onPressed: () {},
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(colorRed),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    textStyle:
                                        MaterialStateProperty.all<TextStyle>(
                                            TextStyle(
                                                // fontSize: heightSize * .025,
                                                fontFamily: 'Text',
                                                fontWeight: FontWeight.w700)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            side: BorderSide(
                                                style: BorderStyle.none))))),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ]),
        )
      ]),
    );
  }
}
