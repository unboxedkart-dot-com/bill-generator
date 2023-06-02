import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unboxedkart/data_providers/repositories/local.repository.dart';

class ApiCalls {
  LocalRepository localRepo = LocalRepository();
  getNewAccessToken(String accessToken) async {
    String refreshToken = await localRepo.getRefreshToken();
    http.Response response = await http.patch(
      Uri.parse(
          "https://server.unboxedkart.com/auth/new-access-token?refreshToken=ea83588e-5a23-48f2-9fb6-4fd477d6b18c"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
    );

    if (response.body.isNotEmpty) {
      final data = json.decode(response.body);
      print(data);
      localRepo.setRefreshToken(data["refreshToken"]);
      localRepo.setAccessToken(data["accessToken"]);
      return "accessToken";
    }
  }

  Future post({String url, dynamic postBody, String accessToken}) async {
    print("running post request");
    print(url);
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode(postBody));

    print("response sss");
    print(response.body);

    if (response.body.isNotEmpty) {
      return json.decode(response.body);
    }
  }

  Future get({String accessToken, String url}) async {
    print("running get request");
    print(url);
    http.Response response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
    );
    print("running get method");
    print(url);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isNotEmpty) {
        return json.decode(response.body);
      }
    } else if (response.statusCode == 401) {}
  }

  Future delete({String accessToken, String url, dynamic deleteBody}) async {
    http.Response response;
    print("running deleting request");
    print(url);
    if (deleteBody != null) {
      response = await http.delete(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken'
          },
          body: jsonEncode(deleteBody));
    } else {
      response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken'
        },
      );
    }
    if (response.body.isNotEmpty) {
      return json.decode(response.body);
    }
  }

  Future update({String accessToken, String url, dynamic updateBody}) async {
    http.Response response = await http.patch(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode(updateBody));

    if (response.body.isNotEmpty) {
      return json.decode(response.body);
    }
  }
}
