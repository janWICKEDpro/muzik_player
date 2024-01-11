import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioPlayerService {
  final _audioPlayer = AudioPlayer();

  Future<List<FileSystemEntity>> getAudio() async {
    List<FileSystemEntity> audioFiles = [];

    await [Permission.storage].request();
    // Directory? directory = Directory('/storage/emulated/0/');

    // Stream<FileSystemEntity> stream = directory.list(recursive: true);
    // audioFiles = await stream.toList();
    Directory? mainDir = await getExternalStorageDirectory();
    if (mainDir == null) {
      exit(0);
    }

    Directory topDir =
        Directory(mainDir.path.substring(0, mainDir.path.indexOf('Android')));

    Stream<FileSystemEntity> files = topDir.list(recursive: true);
    List<FileSystemEntity> filesList = await files.toList();
    return filesList;
  }

  void pause(FileSystemEntity song) async {
    await _audioPlayer.play(DeviceFileSource(song.path));
    await Future.delayed(Duration(seconds: 10));
    await _audioPlayer.stop();
  }

  void play() async {}

  void seek() async {}

  void playNext() async {}

  void playPrev() async {}
}
