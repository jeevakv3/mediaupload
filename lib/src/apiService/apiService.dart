import 'dart:convert';

import '../../allpackages.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String baseUrl = 'https://spotit.cloud/interview/api/';
  Future<dynamic> postData(endpoint, {queryParameter}) async {
    var response =
        await http.post(Uri.parse(baseUrl + endpoint), body: queryParameter);
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    return jsonResponse;
  }

  Future<dynamic> getData() async {
    var response =
        await http.get(Uri.parse('https://api.escuelajs.co/api/v1/products'));
    if (response.statusCode == 200) {
      print(response.body);
      var data = json.decode(response.body);
      return data;
    }
  }
}
