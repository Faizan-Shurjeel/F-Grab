import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
class InstagramDownloader {
  Future<String?> getVideoUrl(String url) async {
    final postId = _extractPostId(url);
    final response = await http.get(
      Uri.parse('https://imginn.com/p/$postId/'),
    );

    if (response.statusCode == 200) {
      final document = parse(response.body);
      return document.querySelector('.downloads a[download]')?.attributes['href'];
    }
    return null;
  }

  String _extractPostId(String url) {
    final regex = RegExp(r'instagram\.com/(?:p|reel|tv)/([^/?]+)');
    return regex.firstMatch(url)?.group(1) ?? '';
  }
}