import 'package:http/http.dart' as http;

class HttpService {
  static Future<dynamic> fetchData(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Exception occurred");
    }
  }
}
