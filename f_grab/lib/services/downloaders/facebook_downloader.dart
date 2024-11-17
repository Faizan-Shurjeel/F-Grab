import 'package:http/http.dart' as http;

class FacebookDownloader {
  Future<String?> getVideoUrl(String url) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36',
      },
    );

    if (response.statusCode == 200) {
      return _parseVideoUrl(response.body);
    }
    return null;
  }

  String? _parseVideoUrl(String html) {
    final hdRegex = RegExp(r'"browser_native_hd_url":"([^"]+)"');
    final sdRegex = RegExp(r'"browser_native_sd_url":"([^"]+)"');

    final hdMatch = hdRegex.firstMatch(html);
    final sdMatch = sdRegex.firstMatch(html);

    return (hdMatch?.group(1) ?? sdMatch?.group(1))?.replaceAll('\\/', '/');
  }
}
