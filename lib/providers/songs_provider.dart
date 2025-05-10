import 'dart:developer';
import 'dart:io';

import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:flutter/material.dart';
import 'package:muzik_player/constants/enums.dart';
import 'package:muzik_player/services/audio_player_service.dart';
import 'package:muzik_player/services/audio_query_service.dart';

class SongsModel extends ChangeNotifier {
  final _audio = AudioPlayerService();
  final _audioQueryService = AudioQueryService();
  List<AudioMetadata> audios = [];
  FileSystemEntity? currentSong;
  GetSongState state = GetSongState.loading;
  AudioMetadata? currentAudio;
  int _currentSongIndex = 0;
  int get currentSongIndex => _currentSongIndex;
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

  playerSong(AudioMetadata audio) {
    _audio.play(audio);
    currentAudio = audio;
    notifyListeners();
  }

  nextSong() {
    if (_currentSongIndex < audios.length - 1) {
      _currentSongIndex++;
      currentAudio = audios[_currentSongIndex];
    } else {
      _currentSongIndex = 0;
      currentAudio = audios[_currentSongIndex];
    }
    _audio.play(currentAudio!);
    notifyListeners();
  }

  previousSong() {
    if (_currentSongIndex > 0) {
      _currentSongIndex--;
      currentAudio = audios[_currentSongIndex];
    } else {
      _currentSongIndex = audios.length - 1;
      currentAudio = audios[_currentSongIndex];
    }
    _audio.play(currentAudio!);
    notifyListeners();
  }
}
