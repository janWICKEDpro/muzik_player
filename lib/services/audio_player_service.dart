import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';

class AudioPlayerService {
  final _audioPlayer = AudioPlayer();

  Future<List<FileSystemEntity>> getAudio() async {
    List<FileSystemEntity> audioFiles = [];

    Directory? directory = Directory('/storage/emulated/0/');
    Future.delayed(Duration(seconds: 1));
    audioFiles = directory
        .listSync(recursive: true, followLinks: false)
        .where((element) => element.path.endsWith('.mp3'))
        .toList();

    log('Got files');
    return audioFiles;
  }

  void pause() async {}

  void play() async {}

  void seek() async {}

  void playNext() async {}

  void playPrev() async {}
}
