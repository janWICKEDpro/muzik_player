import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';

class AudioPlayerService {
  final _audioPlayer = AudioPlayer();

  Future<List<File>> getAudio() async {
    List<File> audioFiles = [];

    Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {}
    return audioFiles;
  }

  void pause() async {}

  void play() async {}

  void seek() async {}

  void playNext() async {}

  void playPrev() async {}
}
