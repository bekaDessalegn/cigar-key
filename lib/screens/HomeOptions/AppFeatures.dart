import 'package:cigarKey/utils/fontSize.dart';
import 'package:flutter/material.dart';
import 'package:cigarKey/widgets/GeneralHeader.dart';

class AppFeatures extends StatefulWidget {
  const AppFeatures({Key? key}) : super(key: key);

  @override
  State<AppFeatures> createState() => _AppFeaturesState();
}

class _AppFeaturesState extends State<AppFeatures>
    with TickerProviderStateMixin {
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
            child: GeneralHeader(
                MediaQuery.of(context).size.height, "App Features"),
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
  new Content('Establish Profile',
      'Personal profile to customize your experience, track and manage preferences and earn rewards.'),
  new Content('Search or Scan',
      '“Cigar Key” QR code for an advanced product description, producing a unique % match of that particular product with the individual user.'),
  new Content('Recommender',
      'Our automated formula will present other cigars that fit your unique taste profile and other cigars similar cigars. '),
  new Content('Locations / Find',
      'Filter and Find locations that have products you like.'),
  new Content('Like', 'A product to save it to your favorites.'),
  new Content('Travel Mode',
      'Feature allows you to set a range outside of your normal zip code, to receive notifications of products and locations when traveling outside of your local area. '),
  new Content('Rewards',
      'Feature further expands your experience by offering new deals and products which users can accumulate through participation.'),
];
