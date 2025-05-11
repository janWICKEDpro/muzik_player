import 'dart:async';
import 'dart:developer';

import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:muzik_player/constants/enums.dart';
import 'package:muzik_player/services/audio_player_service.dart';
import 'package:muzik_player/services/audio_query_service.dart';

class SongsModel extends ChangeNotifier {
  final _audio = AudioPlayerService();
  final _audioQueryService = AudioQueryService();
  List<AudioMetadata> audios = [];
  GetSongState state = GetSongState.loading;
  AudioMetadata? currentAudio;
  int _currentSongIndex = 0;
  int get currentSongIndex => _currentSongIndex;
  Duration? currentDuration;

  PlayerState _currentAudioPlayerState = PlayerState.playing;
  PlayerState get playerState => _currentAudioPlayerState;

  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<PlayerState>? _playerStateSubscription;

  getSongs() async {
    _positionSubscription?.cancel();
    _positionSubscription = null;
    _playerStateSubscription?.cancel();
    _playerStateSubscription = null;
    state = GetSongState.loading;
    notifyListeners();
    try {
      final result = await _audioQueryService.fetchAudios();
      if (result.isNotEmpty) {
        state = GetSongState.success;
        audios = result;
      } else {
        state = GetSongState.empty;
      }
      notifyListeners();
    } catch (e) {
      log('$e');
      state = GetSongState.failed;
      notifyListeners();
    }
  }

  playerSong(AudioMetadata audio) async {
    await _audio.stop();
    await _audio.play(audio);
    currentAudio = audio;
    subscribeToPositionStream();
    subscribeToPlayerState();
    notifyListeners();
  }

  pauseOrPlay() {
    if (currentAudio != null) {
      if (_audio.playerState == PlayerState.paused) {
        _audio.resume();
      } else {
        _audio.pause();
      }
    }
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

  seekSong(double position) {
    _audio.seek(position);
  }

  void subscribeToPositionStream() {
    _positionSubscription = _audio.positionStream.listen((position) {
      currentDuration = position;
      notifyListeners();
    });
  }

  void subscribeToPlayerState() {
    _playerStateSubscription = _audio.playerStateStream.listen((state) {
      _currentAudioPlayerState = state;
      notifyListeners();
    });
  }
}
