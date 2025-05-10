import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:muzik_player/constants/enums.dart';
import 'package:muzik_player/services/audio_player_service.dart';
import 'package:muzik_player/services/audio_query_service.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongsModel extends ChangeNotifier {
  final _audio = AudioPlayerService();
  final _audioQueryService = AudioQueryService();
  List audios = [];
  FileSystemEntity? currentSong;
  GetSongState state = GetSongState.loading;
  SongModel? currentAudio;
  getSongs() async {
    state = GetSongState.loading;
    notifyListeners();
    try {
      final result = await _audioQueryService.fetchAudios();
      if (result.isNotEmpty) {
        log('${result.first}');
      }
      state = GetSongState.success;
      audios = result;
      notifyListeners();
    } catch (e) {
      log('$e');
      state = GetSongState.failed;
      notifyListeners();
    }
  }

  playerSong(SongModel audio) {
    _audio.play(audio);
    currentAudio = audio;
    notifyListeners();
  }

  nextSong() {}
  previousSong() {}
}
