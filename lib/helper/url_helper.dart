import 'dart:convert';
import 'package:http/http.dart' as http;

class UrlHelper {
  // TO PATH ENDPOINT FOR BEASE URL .
  static Uri url(String endPoint) {
    var url = Uri.parse('https://www.toggl.com/api/v8/$endPoint');
    return url;
  }

  // TO PATH TOKEN AND MAKE GENREL HEADER OF ALL REQUESTS .
  static Map<String, String> header([String token]) {
    if (token != null) {
      var header = {
        'Accept': 'application/json',
        "Content-Type": 'application/json',
        'Authorization': 'Basic $token'
      };
      return header;
    } else {
      var header = {
        'Accept': 'application/json',
      };
      return header;
    }
  }

  // GENERAL POST REQUEST
  static Future<dynamic> postRequest(
      Uri url, Map<String, String> header, dynamic body) async {
    final response = await http.post(url, headers: header, body: body);
    final responseData = json.decode(response.body);
    return responseData;
  }

  // GENERAL GET REQUEST
  static Future<dynamic> getRequest(
    Uri url,
    Map<String, String> header,
  ) async {
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData;
    } else {
      return response.statusCode;
    }
  }
}
