import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/download_bloc.dart';
import '../models/download_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Downloader'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<DownloadBloc, DownloadState>(
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Video URL',
                    border: OutlineInputBorder(),
                  ),
                  enabled: !state.isDownloading,
                  onChanged: (value) {
                    context.read<DownloadBloc>().add(UrlChanged(value));
                  },
                ),
                const SizedBox(height: 16),
                if (state.isDownloading) ...[
                  LinearProgressIndicator(value: state.progress),
                  const SizedBox(height: 8),
                  Text('${(state.progress * 100).toInt()}%'),
                ],
                if (state.error != null)
                  Text(
                    state.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                if (state.downloadComplete)
                  const Text(
                    'Download Complete!',
                    style: TextStyle(color: Colors.green),
                  ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: state.isDownloading
                      ? null
                      : () {
                          context.read<DownloadBloc>().add(StartDownload());
                        },
                  icon: const Icon(Icons.download),
                  label: const Text('Download'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
