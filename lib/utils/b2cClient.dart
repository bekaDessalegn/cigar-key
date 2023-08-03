// import 'package:cigarKey/service/ApiService.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';
// // import 'package:msal_flutter/msal_flutter.dart';
// import 'dart:convert';
// import 'package:rounded_loading_button/rounded_loading_button.dart';
//
// class B2CAuth {
//   BuildContext context;
//   RoundedLoadingButtonController _btnController;
//
//   B2CAuth(this.context, this._btnController);
//   static const String _authority =
//       "https://Thecigarkeyb2c.b2clogin.com/tfp/Thecigarkeyb2c.onmicrosoft.com/";
//   static const loginAuth = "B2C_1_signupsignin1";
//   static const String sigupAuthority = "B2C_1_signup";
//   static const String forgetPasswordAuth = "B2C_1_passwordreset";
//   static const String _redirectUri = "msauth.com.cigarKey://auth";
//   static const String _clientId = "95c09424-604f-42a2-9c8d-b1af0cd57b3c";
//   static const _androidRedirectUri =
//       "msauth://com.cigar_key/MdwNqEZlmTewjQLywxlBjx7Shtg%3D";
//   static const _iosRedirectUri = "msauth.com.cigarKey://auth";
//   String _output = 'NONE';
//
//   // PublicClientApplication? pca;
//
//   Future<dynamic> authB2c(isSign) async {
//     // var currentAuth = isSign == 0
//     //     ? loginAuth
//     //     : isSign == 1
//     //         ? sigupAuthority
//     //         : forgetPasswordAuth;
//     // var _authorityUrl = _authority + currentAuth;
//     // print("called acquiretoken${_authorityUrl}");
//     // //create the PCA if not already created
//     // // if (pca == null) {
//     // //   print("creating pca...");
//     // //   pca = await PublicClientApplication.createPublicClientApplication(
//     // //       _clientId,
//     // //       authority: _authorityUrl,
//     // //       iosRedirectUri: _iosRedirectUri,
//     // //       androidRedirectUri: _androidRedirectUri);
//     // // }
//     // String res = "";
//     // try {
//     //   print("pca created${pca}");
//     //   res = await pca!.acquireToken([
//     //     "https://Thecigarkeyb2c.onmicrosoft.com/user_impersonation/user_impersonation"
//     //   ]);
//     //   // Future.delayed(Duration(seconds: 100));
//     //
//     //   print(" ADEDD:${res}");
//     //   final encodedPayload = res.split('.')[1];
//     //   final payloadData =
//     //       utf8.fuse(base64).decode(base64.normalize(encodedPayload));
//     //   print(payloadData);
//     //   var userData = json.decode(payloadData);
//     //   var bodyArgs = {"Email": userData["emails"][0]};
//     //   var data = {
//     //     "FirstName": userData['extension_FirstName'] != null
//     //         ? userData['extension_FirstName']
//     //         : "",
//     //     "LastName": userData['extension_LastName'] != null
//     //         ? userData['extension_LastName']
//     //         : "",
//     //     "Email": userData['emails'][0] != null ? userData['emails'][0] : "",
//     //     "Gender": userData['extension_Gender'] != null
//     //         ? userData['extension_Gender']
//     //         : "",
//     //     "PhoneNumber": userData['extension_PhoneNumber'] != null
//     //         ? userData['extension_PhoneNumber']
//     //         : "",
//     //     "ZipCode": userData['extension_ZipCode'] != null
//     //         ? userData['extension_ZipCode']
//     //         : ""
//     //   };
//     //   await ApiService.getProfile(bodyArgs).then((value) => {
//     //         if (value[0] == '200')
//     //           {
//     //             _btnController.reset(),
//     //             Navigator.pushNamedAndRemoveUntil(
//     //               context,
//     //               '/TabBar',
//     //               (Route<dynamic> route) => false,
//     //             ),
//     //           }
//     //         else
//     //           {
//     //             ApiService.createProfile(data).then((value) => {
//     //                   if (value[0] == "200")
//     //                     {
//     //                       _btnController.reset(),
//     //                       Navigator.pushNamedAndRemoveUntil(
//     //                         context,
//     //                         '/PhotoPage',
//     //                         (Route<dynamic> route) => false,
//     //                       ),
//     //                     }
//     //                   else
//     //                     {
//     //                       res = "User cancelled",
//     //                       _btnController.reset(),
//     //                     }
//     //                 })
//     //           }
//     //       });
//     // } on MsalUserCancelledException {
//     //   res = "User cancelled";
//     //   _btnController.reset();
//     //   return;
//     // } on MsalNoAccountException {
//     //   res = "no account";
//     //   _btnController.reset();
//     //   return;
//     // } on MsalInvalidConfigurationException {
//     //   _btnController.reset();
//     //   res = "invalid config";
//     //   return;
//     // } on MsalInvalidScopeException {
//     //   _btnController.reset();
//     //   res = "Invalid scope";
//     //   return;
//     // } on MsalException {
//     //   _btnController.reset();
//     //   res = "Error getting token. Unspecified reason";
//     //   return;
//     // }
//   }
//
//   Future<dynamic> acquireTokenSilently() async {
//     // if (pca == null) {
//     //   print("initializing pca");
//     //   pca = await PublicClientApplication.createPublicClientApplication(
//     //       _clientId,
//     //       redirectUri: _redirectUri,
//     //       authority: _authority);
//     // }
//     //
//     // String res;
//     // try {
//     //   res = await pca!.acquireToken([
//     //     "https://Thecigarkeyb2c.onmicrosoft.com/user_impersonation/user_impersonation"
//     //   ]);
//     //   Future.delayed(Duration(seconds: 100));
//     // } on MsalUserCancelledException {
//     //   res = "User cancelled";
//     //   return;
//     // } on MsalNoAccountException {
//     //   res = "no account";
//     //   return;
//     // } on MsalInvalidConfigurationException {
//     //   res = "invalid config";
//     //   return;
//     // } on MsalInvalidScopeException {
//     //   res = "Invalid scope";
//     //   return;
//     // } on MsalException {
//     //   res = "Error getting token silently!";
//     //   return;
//     // }
//     // Navigator.pushNamedAndRemoveUntil(
//     //   context,
//     //   '/TabBar',
//     //   (Route<dynamic> route) => false,
//     // );
//     // print("Got token");
//     // print(res);
//     // return res;
//   }
//
//   Future logout() async {
//     // print("called logout");
//     // var _authorityUrl = _authority + loginAuth;
//     // pca = await PublicClientApplication.createPublicClientApplication(_clientId,
//     //     authority: _authorityUrl);
//     //
//     // print("pca is not null");
//     // String res;
//     // try {
//     //   await pca!.logout(browserLogout: true);
//     //   return "200";
//     // } on PlatformException catch (e) {
//     //   res = "some other exception ${e.toString()}";
//     //   return "400";
//     // }
//   }
// }
