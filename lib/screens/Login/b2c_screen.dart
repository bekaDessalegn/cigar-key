import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class B2CScreen extends StatefulWidget {

  @override
  State<B2CScreen> createState() => _B2CScreenState();
}

class _B2CScreenState extends State<B2CScreen> {

  InAppWebViewController? _webViewController;

  // final kClientId = '95c09424-604f-42a2-9c8d-b1af0cd57b3c';
  // final kClientId = '845d5616-d846-4c09-995e-9ba51f9df45d';
  // final kAuthority = 'https://Thecigarkeyb2c.b2clogin.com/tfp/Thecigarkeyb2c.onmicrosoft.com/B2C_1_signupsignin1';
  // final kAuthority = 'https://Thecigarkeyb2c.b2clogin.com/tfp/Thecigarkeyb2c.onmicrosoft.com/B2C_1_signupsignin1';
  // final kRedirectUri = 'msauth.com.cigarKey://auth';
  // final kRedirectUri = 'msauth.com.example.cigarp://auth';
  // final kRedirectUri = 'http://localhost'; This worked for android
  String kAuthority = '';
  String kRedirectUri = '';
  // final kScope = 'openid';

  // https://Thecigarkeyb2c.b2clogin.com/Thecigarkeyb2c.onmicrosoft.com/oauth2/v2.0/authorize?p=B2C_1_signupsignin1&client_id=95c09424-604f-42a2-9c8d-b1af0cd57b3c&nonce=defaultNonce&redirect_uri=msauth.com.cigarKey%3A%2F%2Fauth&scope=openid&response_type=code&prompt=login

  @override
  Widget build(BuildContext context) {

    if (Platform.isAndroid) {
      // Android-specific code
      kAuthority = 'https://Thecigarkeyb2c.b2clogin.com/Thecigarkeyb2c.onmicrosoft.com/oauth2/v2.0/authorize?p=B2C_1_signupsignin1&client_id=845d5616-d846-4c09-995e-9ba51f9df45d&nonce=defaultNonce&redirect_uri=http%3A%2F%2Flocalhost&scope=openid&response_type=id_token&prompt=login';
      kRedirectUri = 'http://localhost';
    } else if (Platform.isIOS) {
      // iOS-specific code
      kAuthority = 'https://Thecigarkeyb2c.b2clogin.com/Thecigarkeyb2c.onmicrosoft.com/oauth2/v2.0/authorize?p=B2C_1_signupsignin1&client_id=95c09424-604f-42a2-9c8d-b1af0cd57b3c&nonce=defaultNonce&redirect_uri=msauth.com.cigarKey%3A%2F%2Fauth&scope=openid&response_type=id_token&prompt=login';
      kRedirectUri = 'msauth.com.cigarkey://auth';
    }

    print("This is the platform");
    print(kRedirectUri);

    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse('$kAuthority')),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            useShouldOverrideUrlLoading: true,
          ),
        ),
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {

          print("YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY");


          final url = navigationAction.request.url;

          print(url);

          if (url.toString().startsWith(kRedirectUri)) {
            await _webViewController?.stopLoading();
            Navigator.of(context).pop(url.toString());
            return NavigationActionPolicy.CANCEL;
          }

          return NavigationActionPolicy.ALLOW;
        },
        onLoadStop: (controller, url) async {

          print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
          print(url);
          if (url.toString().startsWith(kRedirectUri)) {
            await _webViewController?.stopLoading();
            Navigator.of(context).pop(url.toString());
          }
        },
      ),
    );
  }
}
