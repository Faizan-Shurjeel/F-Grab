import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'downloaders/youtube_downloader.dart';
import 'downloaders/twitter_downloader.dart';
import 'downloaders/instagram_downloader.dart';
import 'downloaders/facebook_downloader.dart';

class VideoService {
  final YouTubeDownloader _youtubeDownloader = YouTubeDownloader();
  final TwitterDownloader _twitterDownloader = TwitterDownloader();
  final InstagramDownloader _instagramDownloader = InstagramDownloader();
  final FacebookDownloader _facebookDownloader = FacebookDownloader();

  Future<String?> getVideoUrl(String url) async {
    if (url.contains('youtube.com') || url.contains('youtu.be')) {
      return await _youtubeDownloader.getVideoUrl(url);
    } else if (url.contains('twitter.com')) {
      return await _twitterDownloader.getVideoUrl(url);
    } else if (url.contains('instagram.com')) {
      return await _instagramDownloader.getVideoUrl(url);
    } else if (url.contains('facebook.com')) {
      return await _facebookDownloader.getVideoUrl(url);
    }
    return null;
  }

  Future<void> downloadVideo(String url, Function(double) onProgress) async {
    final client = http.Client();
    final request = http.Request('GET', Uri.parse(url));
    final response = await client.send(request);

    final contentLength = response.contentLength ?? 0;
    var downloaded = 0;

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4');
    final sink = file.openWrite();

    await response.stream.forEach((chunk) {
      sink.add(chunk);
      downloaded += chunk.length;
      if (contentLength > 0) {
        onProgress(downloaded / contentLength);
      }
    });

    await sink.close();
  }
}