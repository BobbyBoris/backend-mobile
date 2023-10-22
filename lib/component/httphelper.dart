import 'dart:convert';
import 'package:agile02/component/date.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  final String _baseUrl = "http://worldtimeapi.org/api/timezone";

  Future<DateData> getTimeForCity(String city) async {
    String url = "$_baseUrl/Asia/Jakarta";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      DateData date = DateData.fromJson(jsonResponse);
      return date;
    } else {
      throw Exception('Failed to load time for $city');
    }
  }
}
