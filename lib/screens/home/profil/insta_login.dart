import 'dart:async';
import 'package:fashion_app/models/profil.dart';
import 'package:fashion_app/models/user.dart';
import 'package:fashion_app/services/instagram.dart';
import 'package:fashion_app/shared/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InstaLogin extends StatefulWidget {
  @override
  _InstaLoginState createState() => _InstaLoginState();
}

class _InstaLoginState extends State<InstaLogin> {
  var url;

  GetIt getIt;
  User user;
  WebViewController _webController;
  InstagramConnector insta;

  @override
  void initState() {
    getIt = GetIt.instance;
    user = getIt.get<User>();
    insta = InstagramConnector(user: user);
    super.initState();
  }

  Future<String> extractCode() async {
    url = await _webController.currentUrl();
  }

  evaluateUrl() {
    extractCode().whenComplete(() => checkForCode());
  }

  void checkForCode() {
    String check = url.toString();
    if (check.startsWith("https://fashion-7bc3d.web.app/")) {
      insta.getAccessToken(
          check.substring(check.indexOf("=") + 1, check.indexOf("#")));
      _webController.clearCache();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: insta.authUrl +
          "authorize?client_id=" +
          Strings.appId +
          "&redirect_uri=" +
          insta.redirectUrl +
          "&scope=user_profile,user_media&response_type=code",
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController c) {
        _webController = c;
      },
      gestureRecognizers: Set()
        ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()
          ..onTapDown = (tap) {
            evaluateUrl();
          })),
    );
  }
}
