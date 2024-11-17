import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
class TwitterDownloader {
  Future<String?> getVideoUrl(String url) async {
    final tweetId = _extractTweetId(url);
    final response = await http.get(
      Uri.parse('https://twitsave.com/info?url=$tweetId'),
    );

    if (response.statusCode == 200) {
      // Parse HTML and extract video URL using html package
      final document = parse(response.body);
      return document.querySelector('video[src*=".mp4"]')?.attributes['src'];
    }
    return null;
  }

  String _extractTweetId(String url) {
    final regex = RegExp(r'status/(\d+)');
    return regex.firstMatch(url)?.group(1) ?? '';
  }
}