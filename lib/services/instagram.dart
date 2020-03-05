import 'package:http/http.dart' as http;
import 'package:facebook_sdk/facebook_sdk.dart';
import 'package:fashion_app/shared/strings.dart';
import 'dart:convert';

class InstagramConnector {
  final String authUrl = "https://api.instagram.com/oauth/";
  final String redirectUrl = "https://fashion-7bc3d.web.app/";
  final String graphUrl = "https://graph.instagram.com/";

  String myIgUserId = "";
  String myIgAccessToken = "";

  void getAccessToken(String code) async {
    http.Response res = await http.post(authUrl + "access_token", body: {
      "client_id": Strings.appId,
      "client_secret": Strings.appSecret,
      "grant_type": "authorization_code",
      "redirect_uri": redirectUrl,
      "code": code
    });
    if (res.statusCode < 200 || res.statusCode > 400 || res.body == null) {
      print("HTTP POST ERROR: " + res.statusCode.toString());
    } else {
      var decodedRes = json.decode(res.body);
      myIgUserId = decodedRes['user_id'].toString();
      myIgAccessToken = decodedRes['access_token'];

      print("User ID: " + myIgUserId);
      print("Access Token: " + myIgAccessToken);
    }
  }
}
