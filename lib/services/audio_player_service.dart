import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerService {
  final _audioPlayer = AudioPlayer();
  void pause() async {
    await _audioPlayer.pause();
  }

  Future<void> play(AudioMetadata song) async {
    await _audioPlayer.play(BytesSource(song.file.readAsBytesSync()));
  }

  void resume() async {
    await _audioPlayer.resume();
  }

  void seek(double position) async {
    await _audioPlayer.seek(Duration(seconds: position.toInt()));
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  Stream<Duration> get positionStream => _audioPlayer.onPositionChanged;
  Stream<PlayerState> get playerStateStream =>
      _audioPlayer.onPlayerStateChanged;
  Stream<Duration> get durationStream => _audioPlayer.onDurationChanged;
  PlayerState get playerState => _audioPlayer.state;
}
