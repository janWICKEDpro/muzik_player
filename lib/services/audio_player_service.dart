import 'dart:developer';
import 'dart:io';
import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioPlayerService {
  final _audioPlayer = AudioPlayer();
  final OnAudioQuery _audioQuery = OnAudioQuery();
  void pause(FileSystemEntity song) async {
    await _audioPlayer.play(DeviceFileSource(song.path));
    await Future.delayed(const Duration(seconds: 10));
    await _audioPlayer.stop();
  }

  void play(AudioMetadata song) async {
    log('$song');
    await _audioPlayer.play(BytesSource(song.file.readAsBytesSync()));
  }

  void seek() async {}

  void playNext() async {}

  void playPrev() async {}
}
