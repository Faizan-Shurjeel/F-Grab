import 'package:http/http.dart' as http;
import 'dart:convert';

class YouTubeDownloader {
  Future<String?> getVideoUrl(String url) async {
    final response = await http.post(
      Uri.parse('https://api.cobalt.tools/api/json'),
      headers: {'Accept': 'application/json'},
      body: {'url': url},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['url'];
    }
    return null;
  }
}
