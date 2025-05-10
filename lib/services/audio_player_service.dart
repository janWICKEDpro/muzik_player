import 'dart:developer';
import 'dart:io';
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

  void play(SongModel song) async {
    log('$song');
    log('${song.uri}');
    log(song.data);
    Uint8List? bytes = await _audioQuery.queryArtwork(
      song.id,
      ArtworkType.AUDIO,
    );
    log("$bytes");
    await _audioPlayer.play(BytesSource(bytes!));
  }

  void seek() async {}

  void playNext() async {}

  void playPrev() async {}
}
