import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioPlayerService {
  final _audioPlayer = AudioPlayer();

  Future<List<FileSystemEntity>> getAudio() async {
    List<FileSystemEntity> audioFiles = [];

    await [
      Permission.storage,
    ].request();
    Directory? directory = Directory('/storage/emulated/0/');

    audioFiles = directory
        .listSync()
        .where((element) => element.path.endsWith('.mp3'))
        .toList();
    return audioFiles;
  }

  void pause() async {}

  void play() async {}

  void seek() async {}

  void playNext() async {}

  void playPrev() async {}
}
