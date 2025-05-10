import 'dart:developer';
import 'dart:io';

import 'package:muzik_player/constants/mediaStore.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AudioQueryService {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  AudioQueryService._();
  static final AudioQueryService _instance = AudioQueryService._();
  factory AudioQueryService() => _instance;

  Future<bool> requestPermission() async {
    try {
      final permissionStatus = await _audioQuery.checkAndRequest();
      return permissionStatus;
    } catch (e) {
      log('Error getting permission status $e');
      rethrow;
    }
  }

  Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      if (await isAndroidElevenOrLater()) {
        if (!await Permission.audio.isGranted) {
          final status = await Permission.audio.request();
          return status.isGranted;
        } else {
          return true;
        }
      } else {
        if (!await Permission.storage.isGranted) {
          final status = await Permission.storage.request();
          return status.isGranted;
        } else {
          return true;
        }
      }
    }
    return false;
  }

  Future<bool> isAndroidElevenOrLater() async {
    if (Platform.isAndroid) {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.sdkInt >= 30;
    }
    return false;
  }

  Future<bool> _isAndroid11OrAbove() async {
    return (await Permission.manageExternalStorage.isGranted) ||
        (await isAndroidElevenOrLater());
  }

  Future<List<FileSystemEntity>> fetchAudios() async {
    try {
      if (await requestStoragePermission()) {
        return await fetchMp3s();
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<FileSystemEntity>> fetchMp3s() async {
    const String downloadsDirectoryPath = "/storage/emulated/0";

    final Directory downloadsDirectory = Directory(downloadsDirectoryPath);
    List<FileSystemEntity> foundMp3s = [];

    try {
      if (await downloadsDirectory.exists()) {
        final entities = downloadsDirectory.listSync().toList();
        entities.removeWhere((e) => e.path == "/storage/emulated/0/Android");
        for (var entity in entities) {
          log('$entity');
          if (entity is Directory) {
            entity.listSync(recursive: true).forEach((element) {
              if (element is File && element.path.endsWith('.mp3')) {
                foundMp3s.add(element);
              }
            });
          }
          if (entity is File) {
            foundMp3s.add(entity);
          }
        }

        final statusMessage = foundMp3s.isNotEmpty
            ? "${foundMp3s.length} MP3 files found."
            : "No MP3 files found in Downloads.";
        log(statusMessage);
        return foundMp3s;
      } else {
        const statusMessage =
            "Downloads directory not found at $downloadsDirectoryPath";
        log(statusMessage);
        throw Exception("An Error Occured");
      }
    } catch (e) {
      final statusMessage = "Error reading directory: $e";
      log(statusMessage);
      throw Exception("Error Occured while fetching audio");
    }
  }

  Future<List<AlbumModel>> fetchAlbums() async {
    try {
      final albums = await _audioQuery.queryAlbums();
      return albums;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ArtistModel>> fetchArtists() async {
    try {
      final artists = await _audioQuery.queryArtists();
      return artists;
    } catch (e) {
      rethrow;
    }
  }

  Future<List> fetchPlaylists() async {
    try {
      final playlists = await _audioQuery.queryPlaylists();
      return playlists;
    } catch (e) {
      rethrow;
    }
  }
}
