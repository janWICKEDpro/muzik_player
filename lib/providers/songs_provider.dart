import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:muzik_player/constants/enums.dart';
import 'package:muzik_player/services/audio_player_service.dart';
import 'package:provider/provider.dart';

class SongsModel extends ChangeNotifier {
  final audio = AudioPlayerService();
  List<FileSystemEntity> songs = [];
  GetSongState state = GetSongState.loading;

  getSongs() async {
    log('Getting songs');
    state = GetSongState.loading;
    notifyListeners();
    try {
      songs = await audio.getAudio();
      state = GetSongState.success;
      notifyListeners();
    } catch (e) {
      log('$e');
      state = GetSongState.failed;
      notifyListeners();
    }
  }

  playerSong() {}
  nextSong() {}
  previousSong() {}
}
