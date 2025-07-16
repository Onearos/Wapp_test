import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client client;
  final String baseUrl;

  ApiClient({required this.client, this.baseUrl = 'http://localhost:3000'});

  Future<dynamic> getWeatherData() async {
    final response = await client.get(Uri.parse('$baseUrl/weather'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
