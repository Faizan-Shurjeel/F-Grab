import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/home_screen.dart';
import 'blocs/download_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Downloader',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => DownloadBloc(),
        child: const HomeScreen(),
      ),
    );
  }
}

// lib/models/download_state.dart
class DownloadState {
  final String url;
  final bool isDownloading;
  final double progress;
  final String? error;
  final bool downloadComplete;

  DownloadState({
    this.url = '',
    this.isDownloading = false,
    this.progress = 0.0,
    this.error,
    this.downloadComplete = false,
  });

  DownloadState copyWith({
    String? url,
    bool? isDownloading,
    double? progress,
    String? error,
    bool? downloadComplete,
  }) {
    return DownloadState(
      url: url ?? this.url,
      isDownloading: isDownloading ?? this.isDownloading,
      progress: progress ?? this.progress,
      error: error,
      downloadComplete: downloadComplete ?? this.downloadComplete,
    );
  }
}
