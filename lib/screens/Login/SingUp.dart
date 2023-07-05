import 'package:cigarKey/utils/fontSize.dart';
import 'package:cigarKey/widgets/GeneralHeader.dart';
import 'package:flutter/material.dart';

class SingUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingUpBody(),
    );
  }
}

class SingUpBody extends StatefulWidget {
  @override
  State<SingUpBody> createState() => _SingUpBodyState();
}

class _SingUpBodyState extends State<SingUpBody> {
  String? gender;
  GlobalKey<FormState> _Key = GlobalKey<FormState>();
  final _myControllerName = TextEditingController();
  final _myControllerLastName = TextEditingController();
  final _myControllerEmail = TextEditingController();
  final _myControllerPhone = TextEditingController();
  final _myControllerLocation = TextEditingController();
  var user = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var widthSize = MediaQuery.of(context).size.width;
    var heightSize = MediaQuery.of(context).size.height;
    Color colorText = Color.fromRGBO(197, 169, 1, 1);
    Color colorBackground = Color.fromRGBO(0, 0, 0, 0.5);
    ButtonStyle buttonStyleRedonde = new ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
        backgroundColor: MaterialStateProperty.all<Color>(colorText));
    // EdgeInsets paddingBtnImage =
    //     EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.width * .06, 0, 0);
    // EdgeInsets paddingTerms = EdgeInsets.fromLTRB(
    //     MediaQuery.of(context).size.width * .02,
    //     MediaQuery.of(context).size.width * .09,
    //     MediaQuery.of(context).size.width * .1,
    //     0);
    // EdgeInsets paddingSingin = EdgeInsets.fromLTRB(
    //     MediaQuery.of(context).size.width * .02,
    //     MediaQuery.of(context).size.width * .09,
    //     MediaQuery.of(context).size.width * .05,
    //     0);
    double buttonWidth = MediaQuery.of(context).size.width * .93;
    List<DropdownMenuItem<String>> _gender = [
      DropdownMenuItem(
          child: Text(
            "Male",
            textScaleFactor: Fonts().textSelect(context),
          ),
          value: 'M'),
      DropdownMenuItem(
          child: Text(
            "Female",
            textScaleFactor: Fonts().textSelect(context),
          ),
          value: 'F'),
    ];
    TextStyle mainTextStyle = TextStyle(
        color: Colors.white,
        // fontSize: heightSize * .022,
        fontFamily: 'Text',
        fontWeight: FontWeight.w100);
    TextStyle urlTextStyle = TextStyle(
      color: colorText,
      fontFamily: 'Text',
      // fontSize: heightSize * .02,
    );

    return Stack(
      children: [
        Wrap(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/fondoCigarkey.png',
              fit: BoxFit.fill,
            ),
          )
        ]),
        SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _Key,
              child: Column(
                children: [
                  GeneralHeader(MediaQuery.of(context).size.height, "sign up"),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: widthSize * .1),
                    child: TextFormField(
                      textAlign: TextAlign.justify,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Text',
                        fontSize: 14 / MediaQuery.of(context).textScaleFactor,
                      ),
                      controller: _myControllerName,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          fontFamily: 'Text',
                          fontSize: 14 / MediaQuery.of(context).textScaleFactor,
                        ),
                        filled: true,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: heightSize * .029,
                            horizontal: widthSize * .05),
                        fillColor: colorBackground,
                        labelStyle: TextStyle(
                          color: Colors.grey[400],
                          height: 5,
                          fontFamily: 'Text',
                          fontSize: 14 / MediaQuery.of(context).textScaleFactor,
                        ),
                        labelText: 'Name',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      validator: (value) {
                        return (value != null && value.length != 0)
                            ? null
                            : "Please fill this field";
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: widthSize * .1, vertical: heightSize * .02),
                    child: TextFormField(
                      textAlign: TextAlign.justify,
                      cursorColor: Colors.white,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Text',
                          fontSize:
                              14 / MediaQuery.of(context).textScaleFactor),
                      controller: _myControllerLastName,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          fontFamily: 'Text',
                          fontSize: 14 / MediaQuery.of(context).textScaleFactor,
                        ),
                        filled: true,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: heightSize * .029,
                            horizontal: widthSize * .05),
                        fillColor: colorBackground,
                        labelStyle: TextStyle(
                          color: Colors.grey[400],
                          height: 5,
                          fontFamily: 'Text',
                        ),
                        labelText: 'Last Name',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      validator: (value) {
                        return (value != null && value.length != 0)
                            ? null
                            : "Please fill this field";
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: widthSize * .1),
                    child: TextFormField(
                      textAlign: TextAlign.justify,
                      cursorColor: Colors.white,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Text',
                          fontSize:
                              14 / MediaQuery.of(context).textScaleFactor),
                      controller: _myControllerEmail,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          fontFamily: 'Text',
                          fontSize: 14 / MediaQuery.of(context).textScaleFactor,
                        ),
                        filled: true,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: heightSize * .029,
                            horizontal: widthSize * .05),
                        fillColor: colorBackground,
                        labelStyle:
                            TextStyle(color: Colors.grey[400], height: 5),
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      validator: (value) {
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value.toString());
                        return (value != null && value.length != 0)
                            ? emailValid
                                ? null
                                : "Email not valid"
                            : "Please fill this field";
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: widthSize * .1, vertical: heightSize * .02),
                    child: TextFormField(
                      textAlign: TextAlign.justify,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.white,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14 / MediaQuery.of(context).textScaleFactor,
                          fontFamily: 'Text'),
                      controller: _myControllerPhone,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: heightSize * .029,
                            horizontal: widthSize * .05),
                        fillColor: colorBackground,
                        labelStyle:
                            TextStyle(color: Colors.grey[400], height: 5),
                        labelText: 'Phone number (Optional)',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: widthSize * .1),
                    child: DropdownButtonFormField(
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Text',
                          fontSize:
                              14 / MediaQuery.of(context).textScaleFactor),
                      decoration: InputDecoration(
                        hintText: 'Select a Gender',
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize:
                                14 / MediaQuery.of(context).textScaleFactor),
                        labelText: 'Gender (Optional)',
                        labelStyle: TextStyle(
                            color: Colors.grey[400],
                            height: 5,
                            fontFamily: 'Text',
                            fontSize:
                                14 / MediaQuery.of(context).textScaleFactor),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: heightSize * .025,
                            horizontal: widthSize * .05),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16)),
                        filled: true,
                        fillColor: colorBackground,
                      ),
                      dropdownColor: colorBackground,
                      onChanged: (String? value) => setState(() {
                        gender = value!;
                      }),
                      value: gender,
                      items: _gender,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: widthSize * .1, vertical: heightSize * .02),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.justify,
                      cursorColor: colorText,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Text',
                          fontSize:
                              14 / MediaQuery.of(context).textScaleFactor),
                      controller: _myControllerLocation,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          fontFamily: 'Text',
                          fontSize: 14 / MediaQuery.of(context).textScaleFactor,
                        ),
                        filled: true,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: heightSize * .029,
                            horizontal: widthSize * .05),
                        fillColor: colorBackground,
                        labelStyle: TextStyle(
                          color: Colors.grey[400],
                          height: 5,
                          fontFamily: 'Text',
                        ),
                        labelText: 'Zip Code',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      validator: (value) {
                        return (value != null && value.length != 0)
                            ? null
                            : "Please fill this field";
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: buttonWidth * 0.85,
                        height: heightSize * .06,
                        child: ElevatedButton(
                            onPressed: () async {
                              print(gender);
                              if (_Key.currentState!.validate()) {
                                Map user = {
                                  "FirstName": _myControllerName.text,
                                  "LastName": _myControllerLastName.text,
                                  "Email": _myControllerEmail.text,
                                  "Gender": gender,
                                  "PhoneNumber": _myControllerPhone.text,
                                  "ZipCode": _myControllerLocation.text,
                                };
                                Navigator.pushNamed(context, '/PhotoPage',
                                    arguments: user);
                              }
                            },
                            style: buttonStyleRedonde,
                            child: Text(
                              "Continue",
                              textScaleFactor: Fonts().textButton(context),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Text',
                                  // fontSize: heightSize * .02,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: heightSize * .02),
                      child: Text(
                        "By continuing, you accept our",
                        textScaleFactor: Fonts().textSmall(context),
                        style: mainTextStyle,
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: heightSize * .02,
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Privacy Policy ', style: urlTextStyle),
                          TextSpan(
                            text: '& ',
                            style: mainTextStyle,
                          ),
                          TextSpan(
                              text: 'Termns and Conditions',
                              style: urlTextStyle),
                        ],
                      ),
                      textScaleFactor: Fonts().textverySmall(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
