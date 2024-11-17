import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/download_state.dart';
import '../services/video_service.dart';

abstract class DownloadEvent {}

class UrlChanged extends DownloadEvent {
  final String url;
  UrlChanged(this.url);
}

class StartDownload extends DownloadEvent {}

class ClearError extends DownloadEvent {}

class ResetDownloadState extends DownloadEvent {}

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  final VideoService _videoService = VideoService();

  DownloadBloc() : super(DownloadState()) {
    on<UrlChanged>((event, emit) {
      emit(state.copyWith(url: event.url));
    });

    on<StartDownload>((event, emit) async {
      if (state.url.isEmpty) {
        emit(state.copyWith(error: 'Please enter a URL'));
        return;
      }

      emit(state.copyWith(
        isDownloading: true,
        progress: 0.0,
        error: null,
      ));

      try {
        final String? videoUrl = await _videoService.getVideoUrl(state.url);
        
        if (videoUrl == null) {
          emit(state.copyWith(
            isDownloading: false,
            error: 'Could not retrieve video URL',
          ));
          return;
        }

        await _videoService.downloadVideo(
          videoUrl,
          (progress) => emit(state.copyWith(progress: progress)),
        );

        emit(state.copyWith(
          isDownloading: false,
          downloadComplete: true,
          url: '',
        ));
      } catch (e) {
        emit(state.copyWith(
          isDownloading: false,
          error: e.toString(),
        ));
      }
    });

    on<ClearError>((event, emit) {
      emit(state.copyWith(error: null));
    });

    on<ResetDownloadState>((event, emit) {
      emit(state.copyWith(downloadComplete: false));
    });
  }
}