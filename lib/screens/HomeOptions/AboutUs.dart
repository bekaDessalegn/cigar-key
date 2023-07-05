import 'package:cigarKey/utils/fontSize.dart';
import 'package:flutter/material.dart';
import 'package:cigarKey/widgets/GeneralHeader.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;
    final ScrollController controllerOne = ScrollController();

    int selected = -1;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Wrap(children: [
          Container(
            child:
                GeneralHeader(MediaQuery.of(context).size.height, "About Us"),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: heightSize * .8,
              width: widthSize,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: widthSize * .05),
                      child: ListView.separated(
                        key: Key('builder ${selected.toString()}'),
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        controller: controllerOne,
                        shrinkWrap: true,
                        itemCount: contentList.length,
                        separatorBuilder: (_, __) => Divider(
                          color: Colors.white,
                          height: 2,
                          // indent: widthSize * .05,
                          // endIndent: widthSize * .05,
                        ),
                        itemBuilder: (context, i) {
                          return new ExpansionTile(
                            key: Key(i.toString()),
                            initiallyExpanded: i == selected,
                            iconColor: Color.fromRGBO(156, 27, 23, 1),
                            collapsedIconColor: Color.fromRGBO(156, 27, 23, 1),
                            title: Text(
                              contentList[i].title,
                              textScaleFactor: Fonts().text(context),
                              style: TextStyle(
                                color: Colors.white,
                                // fontSize: heightSize * .03
                              ),
                            ),
                            childrenPadding: EdgeInsets.symmetric(
                                vertical: heightSize * .02),
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: widthSize * .1),
                                child: Text(
                                  contentList[i].description,
                                  textScaleFactor: Fonts().textSmall(context),
                                  style: TextStyle(
                                    fontFamily: 'Text',
                                    color: Colors.grey.shade500,
                                    // fontSize: heightSize * .02,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              )
                            ],
                            onExpansionChanged: ((newState) {
                              if (newState) {
                                setState(() {
                                  selected = i;
                                });
                              } else {
                                setState(() {
                                  selected = -1;
                                });
                              }
                            }),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class Content {
  final String title;
  final String description;

  Content(this.title, this.description);
}

List<Content> contentList = [
  new Content('What',
      'Cigar Key is a tool for cigar enthusiast to explore the cigar world, thus expanding & enhancing the experience.'),
  new Content('Why',
      'Walking into a humidor to make a cigar selection can be an overwhelming experience, for both novice and advanced cigar smokers. Shop owners are often challenged with helping customers make suggestions without much information about the customers preferences. Customers are often left doing an “eeny, meeny, miny, moe” selection of brands, labels, etc. Cigar Key offers a solution. '),
  new Content('How it works',
      '“Cigar Key” is your locksmith. Using a unique proprietary formula and process design to pair cigar enthusiast with cigars that fall into their preference zone. We have developed an automated recommender system which offers suggestions and recommendations allowing users to make selections, based on their unique pallet preferences. '),
];
