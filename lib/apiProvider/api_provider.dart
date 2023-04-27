import 'package:http/http.dart' as http;

class ApiProvider {
  static final ApiProvider _singletonApiProvider = ApiProvider._internal();

  factory ApiProvider() {
    return _singletonApiProvider;
  }

  ApiProvider._internal();

  Future getMethod(String apiUrl) async {
    var url = Uri.parse(apiUrl);
    var response = await http.get(url);

    return response.body;
  }
}
