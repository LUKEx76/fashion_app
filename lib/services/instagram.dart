import 'package:http/http.dart' as http;
import 'package:facebook_sdk/facebook_sdk.dart';

class InstagramConnector {
  //DONT PUSH SECRETS TO GITHUB
  final String baseApiUrl = "https://api.instagram.com/";
  final String redirectUrl = "https://google.com/";
  final String graphUrl = "https://graph.instagram.com/";
  String code = "";
  String userData = "";

//SECRETS
  String appId = "";
  String myIgUserId = "";
  String myIgAccessToken = "";

  //UNUSED
  Future<String> fetchCode() async {
    http.Response res = await http.get(baseApiUrl +
        "oauth/authorize?client_id=" +
        appId +
        "&redirect_uri=" +
        redirectUrl +
        "&scope=user_profile,user_media&response_type=code");

    for (String key in res.headers.keys) {
      code += key + " - ";
    }
    return "Success";
  }

  Future<http.Response> getIgUserData() async {
    http.Response res = await http.get(graphUrl +
        myIgUserId +
        "?fields=id,username&access_token=" +
        myIgAccessToken);

    userData = res.body.toString();
  }
}
