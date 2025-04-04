import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

///import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioPlayerService {
  final _audioPlayer = AudioPlayer();

//  final OnAudioQuery _audioQuery = OnAudioQuery();

  // Future<List<FileSystemEntity>> getAudio() async {
  //   List<FileSystemEntity> audioFiles = [];

  //   await [Permission.storage].request();
  //   // Directory? directory = Directory('/storage/emulated/0/');

  //   // Stream<FileSystemEntity> stream = directory.list(recursive: true);
  //   // audioFiles = await stream.toList();
  //   Directory? mainDir = await getExternalStorageDirectory();
  //   if (mainDir == null) {
  //     exit(0);
  //   }

  //   // Directory topDir =
  //   //     Directory(mainDir.path.substring(0, mainDir.path.indexOf('Android')));

  //   // Stream<FileSystemEntity> files =
  //   //     topDir.list(recursive: true, followLinks: false);

  //   // await   traverseDirectories(topDir, audioFiles);
  //   // //  List<FileSystemEntity> filesList = await files.toList();
  //   return audioFiles;
  // }

  // traverseDirectories(Directory dir, List<FileSystemEntity> mp3Files) async {
  //   List<FileSystemEntity> entities = dir.listSync();
  //   for (FileSystemEntity entity in entities) {
  //     if (entity is Directory) {
  //       // Exclude Android/data and Android/obb directories
  //       String directoryPath = entity.path;
  //       if (directoryPath.contains('Android/data') ||
  //           directoryPath.contains('Android/obb')) {
  //         continue;
  //       }
  //       log('recursing');
  //       await traverseDirectories(entity, mp3Files);
  //     } else if (entity is File) {
  //       var filePath = entity;
  //       if (filePath.path.endsWith('.mp3')) {
  //         log('added file');
  //         mp3Files.add(filePath);
  //       }
  //     }
  //   }
  // }

  // Future<List> getAudios() async {
  //   try {
  //     //    return await _audioQuery.querySongs();
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

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
