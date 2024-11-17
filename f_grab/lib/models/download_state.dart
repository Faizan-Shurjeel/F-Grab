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