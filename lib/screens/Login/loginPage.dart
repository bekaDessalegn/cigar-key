//import 'package:aad_oauth/model/config.dart';
import 'package:cigarKey/model/UserProfileModel.dart';
import 'package:cigarKey/presentation/custom__icons_icons.dart';
import 'package:cigarKey/providers/provider.dart';
import 'package:cigarKey/screens/Login/b2c_screen.dart';
import 'package:cigarKey/service/ApiService.dart';
import 'package:cigarKey/utils/fontSize.dart';
import 'package:cigarKey/widgets/ErrorPopup.dart';
import 'package:flutter/material.dart';
// import 'package:location/location.dart' as locate;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:flutter/services.dart';
import 'package:cigarKey/utils/b2cClient.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBody(),
    );
  }
}

class LoginBody extends StatefulWidget {
  @override
  State<LoginBody> createState() => _LoginBodyState();
}

final String login = '';
final String pass = '';

class _LoginBodyState extends State<LoginBody> {

  FlutterAppAuth _appAuth = FlutterAppAuth();
  // locate.Location location = locate.Location();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  String? token;

  @override
  void initState() {
    super.initState();
    serviceStat();
  }

  Future serviceStat() async {
    // locate.PermissionStatus serviceEnables = await location.hasPermission();
    // if (serviceEnables != locate.PermissionStatus.granted) {
    //   await location.requestPermission();
    // }
  }

  Widget build(BuildContext context) {
    // var b2cClient = B2CAuth(context, _btnController);
    var provider = Provider.of<MyProvider>(context);
    final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;
    Color colorText = Color.fromRGBO(197, 169, 1, 1);
    Color colorWine = Color.fromRGBO(106, 4, 5, 0.7);
    final double screenScale = MediaQuery.of(context).size.height > 670 ? 5 : 6;
    ButtonStyle buttonStyleRedonde = new ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
        backgroundColor: MaterialStateProperty.all<Color>(colorText));
    // EdgeInsets paddingSingin = EdgeInsets.fromLTRB(
    //     MediaQuery.of(context).size.width * .02,
    //     MediaQuery.of(context).size.width * .09,
    //     MediaQuery.of(context).size.width * .05,
    //     0);

    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            width: widthSize,
            height: heightSize,
            child: Image(
              image: AssetImage('assets/fondoCigarkey.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Wrap(
          children: [
            Container(
                width: widthSize,
                height: heightSize * .9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(padding: EdgeInsets.all(heightSize * .021)),
                    Image.asset(
                      'assets/logoBlanco.png',
                      scale: screenScale,
                    ),
                    Padding(padding: EdgeInsets.all(heightSize * .01)),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: widthSize * .1),
                    //   child: Container(
                    //     height: heightSize * .07,
                    //     child: TextField(
                    //       cursorColor: Color.fromARGB(255, 196, 168, 37),
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         // fontSize: widthSize * .045,
                    //         fontSize:
                    //             14 / MediaQuery.of(context).textScaleFactor,
                    //         fontFamily: 'Text',
                    //       ),
                    //       decoration: InputDecoration(
                    //           fillColor: Color.fromRGBO(0, 0, 0, .5),
                    //           filled: true,
                    //           hintText: 'User',
                    //           prefixIconColor: Colors.white,
                    //           iconColor: Colors.white,
                    //           focusColor: colorText,
                    //           focusedBorder: OutlineInputBorder(
                    //               borderRadius:
                    //                   BorderRadius.all(Radius.circular(16))),
                    //           hintStyle: TextStyle(
                    //               color: Colors.grey.shade800,
                    //               // fontSize: widthSize * .04,
                    //               fontSize: 14 /
                    //                   MediaQuery.of(context).textScaleFactor,
                    //               fontFamily: 'Text'),
                    //           prefixIcon: Icon(
                    //             CustomIcons.user,
                    //             color: Colors.white,
                    //           ),
                    //           border: OutlineInputBorder(
                    //               borderSide: BorderSide(color: Color(0xFF)),
                    //               borderRadius:
                    //                   BorderRadius.all(Radius.circular(20)))),
                    //     ),
                    //   ),
                    // ),
                    // Padding(padding: EdgeInsets.all(heightSize * .01)),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: widthSize * .1),
                    //   child: Container(
                    //     height: heightSize * .07,
                    //     child: TextField(
                    //       obscureText: true,
                    //       cursorColor: Color.fromARGB(255, 196, 168, 37),
                    //       style: TextStyle(
                    //           color: Colors.white,
                    //           // fontSize: widthSize * .045,
                    //           fontSize:
                    //               14 / MediaQuery.of(context).textScaleFactor,
                    //           fontFamily: 'Text'),
                    //       decoration: InputDecoration(
                    //           fillColor: Color.fromRGBO(0, 0, 0, .5),
                    //           filled: true,
                    //           hintText: 'Password',
                    //           prefixIconColor: Colors.white,
                    //           iconColor: Colors.white,
                    //           focusColor: colorText,
                    //           focusedBorder: OutlineInputBorder(
                    //               borderRadius:
                    //                   BorderRadius.all(Radius.circular(16))),
                    //           hintStyle: TextStyle(
                    //               color: Colors.grey.shade800,
                    //               // fontSize: widthSize * .04,
                    //               fontSize: 14 /
                    //                   MediaQuery.of(context).textScaleFactor,
                    //               fontFamily: 'Text'),
                    //           prefixIcon: Image.asset(
                    //             'assets/password.png',
                    //             scale: 3.5,
                    //           ),
                    //           border: OutlineInputBorder(
                    //               borderSide: BorderSide(color: Color(0xFF)),
                    //               borderRadius:
                    //                   BorderRadius.all(Radius.circular(20)))),
                    //     ),
                    //   ),
                    // ),
                    Padding(padding: EdgeInsets.all(heightSize * .001)),
                    // TextButton(
                    //     onPressed: () {
                    //       b2cClient.authB2c(2);
                    //       //Navigator.pushNamed(context, '/ForgotPassword');
                    //     },
                    //     child: Text(
                    //       'Forgot Password?',
                    //       textScaleFactor: Fonts().textSmall(context),
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         // fontSize: heightSize * .02,
                    //         fontFamily: 'Text',
                    //       ),
                    //     )),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: heightSize * .05)),
                    RoundedLoadingButton(
                      width: widthSize * .8,
                      height: heightSize * .06,
                      borderRadius: 12,
                      color: colorWine,
                      successColor: colorWine,
                      controller: btnController,
                      child: Text(
                        'Unlock',
                        textScaleFactor: Fonts().textTitle(context),
                        style: TextStyle(
                            color: Colors.white,
                            // fontSize: heightSize * .02,
                            fontFamily: 'Title',
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        //loadData();
                        // await b2cImp();
                        // var accessToken = b2cClient.authB2c(0);
                        final result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => B2CScreen(btnController: btnController,)));
                        if (result != null && result is String) {
                          print(result);
                          final idToken = extractIdTokenFromUrl(result);
                          Map<String, dynamic> decodedToken = JwtDecoder.decode(idToken);
                          print(idToken);
                          print(decodedToken);
                          print(decodedToken["emails"][0] ?? "");
                          UserProfileModel profile = UserProfileModel.fromJson(decodedToken);
                          print(profile.PhoneNumber);
                          try {
                            var bodyArgs = {
                              "Email": decodedToken["emails"][0] ?? ""
                            };
                            await ApiService.getProfile(bodyArgs)
                                .then((value) async {

                                  return {

                              if (value[0] == '200')
                                {
                                  await ApiService.isPrefrencesNull(bodyArgs)
                                      .then((value) async {

                                    return {

                                      if (value[0] == '200')
                                        {
                                          if(value[1]){
                                            setState(() {
                                              btnController.success();
                                              provider.test = "pinea";
                                              Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/StartTest',
                                                    (Route<dynamic> route) => false,
                                              );
                                            }),
                                          } else {
                                            setState(() {
                                              btnController.success();
                                              provider.test = "pinea";
                                              Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/TabBar',
                                                    (Route<dynamic> route) => false,
                                              );
                                            }),
                                          }
                                        }
                                      else
                                        {
                                          btnController.reset(),
                                          ErrorPopUp.errorPopUp(
                                              context, "${value[1]}")
                                        }
                                    };
                                  })
                                }
                              else
                                {
                                  if(value[0] == "404"){
                                    await ApiService.createProfile(profile.toJson())
                                        .then((value) async {

                                      return {

                                        if (value[0] == '200')
                                          {
                                            // setState(() {
                                            //   btnController.success();
                                            //   provider.test = "pinea";
                                            //   Navigator.pushNamedAndRemoveUntil(
                                            //     context,
                                            //     '/TabBar',
                                            //         (Route<dynamic> route) => false,
                                            //   );
                                            // }),
                                            await ApiService.getProfile(bodyArgs)
                                                .then((value) async {

                                              return {

                                                if (value[0] == '200')
                                                  {
                                                    setState(() {
                                                      btnController.success();
                                                      provider.test = "pinea";
                                                      Navigator.pushNamedAndRemoveUntil(
                                                        context,
                                                        '/StartTest',
                                                            (Route<dynamic> route) => false,
                                                      );
                                                    }),
                                                  }
                                                else
                                                  {
                                                      btnController.reset(),
                                                      ErrorPopUp.errorPopUp(
                                                          context, "${value[1]}")
                                                  }
                                              };
                                            })
                                          }
                                        else
                                          {
                                            btnController.reset(),
                                            ErrorPopUp.errorPopUp(
                                                context, "${value[1]}")
                                          }
                                      };
                                    })
                                  } else {
                                    btnController.reset(),
                                    ErrorPopUp.errorPopUp(
                                        context, "${value[1]}")
                                  }
                                }
                            };
                                });
                          } catch (e) {
                            print(e);
                            //ERROR POPUP
                          }
                        }
                        // try {
                        //   var bodyArgs = {
                        //     "Email": "mauricio.rios@revstarconsulting.com"
                        //   };
                        //   await ApiService.getProfile(bodyArgs)
                        //       .then((value) => {
                        //             if (value[0] == '200')
                        //               {
                        //                 setState(() {
                        //                   _btnController.success();
                        //                   provider.test = "pinea";
                        //                   Navigator.pushNamedAndRemoveUntil(
                        //                     context,
                        //                     '/TabBar',
                        //                     (Route<dynamic> route) => false,
                        //                   );
                        //                 }),
                        //               }
                        //             else
                        //               {
                        //                 _btnController.reset(),
                        //                 ErrorPopUp.errorPopUp(
                        //                     context, "${value[1]}")
                        //               }
                        //           });
                        // } catch (e) {
                        //   print(e);
                        //   //ERROR POPUP
                        // }
                      },
                    ),
                    Padding(padding: EdgeInsets.all(heightSize * .01)),
                    // Row(children: [
                    //   Expanded(
                    //       child: Divider(
                    //     color: Color.fromRGBO(255, 255, 255, .15),
                    //     indent: widthSize * .1,
                    //     endIndent: widthSize * .02,
                    //   )),
                    //   Text(
                    //     'Or sign in with',
                    //     textScaleFactor: Fonts().textverySmall(context),
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       // fontSize: heightSize * .018,
                    //       fontFamily: 'Text',
                    //     ),
                    //   ),
                    //   Expanded(
                    //       child: Divider(
                    //     color: Color.fromRGBO(255, 255, 255, .15),
                    //     indent: widthSize * .02,
                    //     endIndent: widthSize * .1,
                    //   )),
                    // ]),
                    Padding(padding: EdgeInsets.all(heightSize * .01)),
                    // SizedBox(
                    //   width: widthSize * .8,
                    //   height: heightSize * .06,
                    //   child: ElevatedButton(
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Icon(
                    //             Icons.facebook,
                    //             color: Colors.white,
                    //             size: heightSize * .035,
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.only(right: 20.0),
                    //             child: Text(
                    //               'Facebook',
                    //               textScaleFactor:
                    //                   Fonts().textverySmall(context),
                    //               style: TextStyle(
                    //                   fontFamily: 'Text',
                    //                   // fontSize: heightSize * .02,
                    //                   fontWeight: FontWeight.bold),
                    //             ),
                    //           ),
                    //           Container()
                    //         ],
                    //       ),
                    //       onPressed: () async {
                    //         b2cClient.authB2c(0);
                    //         // initiateFaceboolLogin().then((response) {
                    //         //   switch (response) {
                    //         //     case 'user':
                    //         //       Navigator.of(context).pop();
                    //         //       Navigator.pushAndRemoveUntil(
                    //         //         context,
                    //         //         MaterialPageRoute(
                    //         //             builder: (context) => TabBarPage()),
                    //         //         (Route<dynamic> route) => false,
                    //         //       );
                    //         //       break;
                    //         //     default:
                    //         //       ErrorPopUp.errorPopUp(context, response);
                    //         //   }
                    //         // });
                    //       },
                    //       style: ButtonStyle(
                    //           backgroundColor: MaterialStateProperty.all(
                    //               Color.fromRGBO(255, 255, 255, 0.1)),
                    //           foregroundColor:
                    //               MaterialStateProperty.all(Colors.white),
                    //           textStyle: MaterialStateProperty.all<TextStyle>(
                    //               TextStyle(fontSize: heightSize * .025)),
                    //           shape: MaterialStateProperty.all<
                    //                   RoundedRectangleBorder>(
                    //               RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(12),
                    //                   side: BorderSide(
                    //                       style: BorderStyle.none))))),
                    // ),

                    Padding(padding: EdgeInsets.all(heightSize * .01)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.qr_code_rounded,
                          color: Colors.white,
                          size: heightSize * .03,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/ScanQR");
                            },
                            child: Text('Scan QR Code',
                                textScaleFactor: Fonts().textSmall(context),
                                style: TextStyle(
                                    // fontSize: heightSize * .022,
                                    color: Colors.white,
                                    fontFamily: 'Text',
                                    fontWeight: FontWeight.bold)))
                      ],
                    ),
                    // Padding(padding: EdgeInsets.all(heightSize * .02)),
                  ],
                )),
            // Container(
            //   width: widthSize,
            //   height: heightSize * .1,
            //   child: Padding(
            //     padding: EdgeInsets.only(bottom: heightSize * .05),
            //     child: Align(
            //       alignment: Alignment.bottomCenter,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //         children: [
            //           Container(
            //             width: widthSize * 0.8,
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Text(
            //                   'Don’t have an account?',
            //                   textScaleFactor: Fonts().textSmall(context),
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontFamily: 'Text',
            //                     // fontSize: heightSize * .018,
            //                   ),
            //                 ),
            //                 Container(
            //                   height: heightSize * .05,
            //                   width: widthSize * .25,
            //                   child: ElevatedButton(
            //                       onPressed: () {
            //                         b2cClient.authB2c(1);
            //                         //Navigator.pushNamed(context, "/SingUp");
            //                       },
            //                       style: buttonStyleRedonde,
            //                       child: Text(
            //                         "Sign up",
            //                         textScaleFactor:
            //                             Fonts().textButton(context),
            //                         style: TextStyle(
            //                             color: Colors.black,
            //                             fontFamily: 'Text',
            //                             // fontSize: heightSize * .018,
            //                             fontWeight: FontWeight.bold),
            //                       )),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }

  String extractIdTokenFromUrl(String url) {
    final startIndex = url.indexOf('id_token=');
    if (startIndex != -1) {
      final endIndex = url.indexOf('&', startIndex);
      return endIndex != -1
          ? url.substring(startIndex + 9, endIndex)
          : url.substring(startIndex + 9);
    }
    return "";
  }

}

// final Config config = new Config(
//     tenant: '9023e035-5215-4a78-a98f-384afd517590',
//     clientId: '845d5616-d846-4c09-995e-9ba51f9df45d',
//     redirectUri: "http://localhost/",
//     scope: 'openid',
//     navigatorKey: GlobalKey());

// void signIn(String email, String password) async {
//   config.loginHint = email;
//   final AadOAuth oauth = new AadOAuth(config);

//   await oauth.login();
//   final accessToken = await oauth.getAccessToken();

//   final graphResponse = await http.get(
//       Uri.parse(
//           "https://thecigarkeyb2c.b2clogin.com/Thecigarkeyb2c.onmicrosoft.com/v2.0/.well-known/openid-configuration?p=B2C_1_signup"),
//       headers: {
//         "Authorization": "Bearer " + "$accessToken",
//         "Content-Type": "application/json"
//       });
//   switch (graphResponse.statusCode) {
//     case HttpStatus.ok:
//       break;
//     default:
//       break;
//   }
// }

Future<String> initiateFaceboolLogin() async {
  final LoginResult result =
      await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
  if (result.status == LoginStatus.success) {
    final requestData = await FacebookAuth.i.getUserData(fields: "email, name");
    final AccessToken accessToken = result.accessToken!;
    return await ApiService.createSocial(accessToken.token);
  } else {
    return result.message.toString();
  }
}
