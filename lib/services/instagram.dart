import 'package:fashion_app/models/igAccessToken.dart';
import 'package:fashion_app/services/database.dart';
import 'package:http/http.dart' as http;
import 'package:fashion_app/shared/strings.dart';
import 'dart:convert';

class InstagramConnector {
  final String authUrl = "https://api.instagram.com/oauth/";
  final String redirectUrl = "https://fashion-7bc3d.web.app/";
  final String graphUrl = "https://graph.instagram.com/";

  String _shortLivedAccessToken;
  String _userId;
  String _longLivedAccessToken;

  DatabaseService _databaseService = DatabaseService();

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
      var decodedResponse = json.decode(res.body);
      _userId = decodedResponse['user_id'].toString();
      _shortLivedAccessToken = decodedResponse['access_token'];

      getLongLivedAccessToken();
    }
  }

  void getLongLivedAccessToken() async {
    var response = await makeGetRequest(graphUrl +
        "access_token?grant_type=ig_exchange_token&client_secret=" +
        Strings.appSecret +
        "&access_token=" +
        _shortLivedAccessToken);
    _longLivedAccessToken = response['access_token'] ?? "";
    _databaseService.saveIgCredentials(_userId, _longLivedAccessToken);
  }

  //Might do different Methods for own Profil and others
  Future<List<String>> allPhotosOfUser() async {
    IgAccessToken accessToken = await _databaseService.accessToken.first;
    var response = await makeGetRequest(graphUrl +
        accessToken.igUserId +
        "?fields=media&access_token=" +
        accessToken.igAccessToken);

    if (response == null) {
      return null;
    }
    List<dynamic> allMediaIdsMap = response['media']['data'];
    List<String> allMediaIds = List<String>();
    for (Map media in allMediaIdsMap) {
      allMediaIds.add(media.values.first.toString());
    }
    List<String> allMediaUrls = List<String>();
    for (String mediaId in allMediaIds) {
      var response = await makeGetRequest(graphUrl +
          mediaId +
          "?fields=media_url&access_token=" +
          accessToken.igAccessToken);
      allMediaUrls.add(response['media_url'] ?? "");
    }
    return allMediaUrls;
  }

  dynamic makeGetRequest(String url) async {
    http.Response res = await http.get(url);
    if (res.statusCode < 200 || res.statusCode > 400 || res.body == null) {
      print("GET REQUEST ON API FAILED: " + res.statusCode.toString());
      return null;
    } else {
      return json.decode(res.body);
    }
  }
}
