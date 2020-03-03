import 'package:http/http.dart' as http;
import 'package:facebook_sdk/facebook_sdk.dart';

class InstagramConnector {
  //DONT PUSH SECRETS TO GITHUB
  final String baseApiUrl = "https://api.instagram.com/";
  final String redirectUrl = "https://fashion-7bc3d.web.app/";
  final String graphUrl = "https://graph.instagram.com/";
  String userData = "";

  //FROM POSTMAN
  String myIgUserId = "17841400726355647";
  String myIgAccessToken =
      "IGQVJYTnBHcGRjSkFOWEhDTDlYRW9FakhXekJVSUJaTDlXZAEVybmx1eThBYkRxX0tmSFhKSlNhU3ctY0NzX1B0MWwzQkxvUmdnM3BVMXY1STNYX2c0TThFXzNyYUctMVBjRDFTR3BzYkE2ZA29fMlNET2RQSWh4RXBNYXVn";

  void getAccessToken(String code) {
    //Get User Token from Code
  }

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
