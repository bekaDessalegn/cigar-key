import 'package:cigarKey/utils/fontSize.dart';
import 'package:cigarKey/widgets/GeneralPopUp.dart';
import 'package:flutter/material.dart';
import 'package:cigarKey/utils/fontSize.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForgotPasswordBody(),
    );
  }
}

class ForgotPasswordBody extends StatefulWidget {
  @override
  State<ForgotPasswordBody> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordBody> {
  final _myControllerEmail = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * .93;
    EdgeInsets paddingBtnReset =
        EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.width * .05, 0, 0);
    var widthSize = MediaQuery.of(context).size.width;
    Color colorText = Color.fromRGBO(197, 169, 1, 1);
    Color colorBackground = Color.fromRGBO(0, 0, 0, 0.5);
    ButtonStyle buttonStyleRedonde = new ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
        backgroundColor: MaterialStateProperty.all<Color>(colorText));

    return Wrap(
      children: [
        Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/fondoCigarkey.png',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .15,
                    horizontal: MediaQuery.of(context).size.height * .1),
                child: Text(
                  'FORGOT \nPASSWORD?',
                  textScaleFactor: Fonts().textTitle(context),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Title',
                    // fontSize: MediaQuery.of(context).size.height * .035,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * .01),
                child: Text(
                  'Please enter the email you used to register',
                  textScaleFactor: Fonts().textSmall(context),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Text',
                    // fontSize: MediaQuery.of(context).size.width * .03
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .1,
                    vertical: MediaQuery.of(context).size.width * .05),
                child: TextFormField(
                  textAlign: TextAlign.justify,
                  cursorColor: Colors.white,
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Text', fontSize: 14),
                  controller: _myControllerEmail,
                  decoration: InputDecoration(
                    filled: true,
                    isDense: true,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20, 40, 0, 0),
                    fillColor: colorBackground,
                    hintStyle: TextStyle(color: Colors.grey[700]),
                    hintText: 'Example@email.com',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: buttonWidth * 0.85,
                    height: widthSize * .15,
                    padding: paddingBtnReset,
                    child: ElevatedButton(
                        onPressed: () async {
                          GeneralPopUp.generalPopUp(context,
                              "A link to reset your password has been sent to ${_myControllerEmail.text}");
                        },
                        style: buttonStyleRedonde,
                        child: Text(
                          "Reset Password",
                          textScaleFactor: Fonts().textButton(context),
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Text',
                              // fontSize: MediaQuery.of(context).size.width * .03,
                              fontWeight: FontWeight.w700),
                        )),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width * .3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 13,
                        )),
                    Text(
                      'Back to Login',
                      textScaleFactor: Fonts().textButton(context),
                      style: TextStyle(
                          fontFamily: 'Text',
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * .03),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ]),
      ],
    );
  }
}
