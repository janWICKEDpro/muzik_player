import 'dart:developer';
import 'dart:io';

import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AudioQueryService {
  AudioQueryService._();
  static final AudioQueryService _instance = AudioQueryService._();
  factory AudioQueryService() => _instance;

  Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      if (await isAndroidElevenOrLater()) {
        log("here 11 and up");
        if (!(await Permission.manageExternalStorage.isGranted)) {
          log("no manage external storage");
          final status1 = await Permission.manageExternalStorage.request();
          if (!(await Permission.audio.isGranted)) {
            log("no audio permission");
            final status = await Permission.audio.request();
            return status.isGranted;
          } else {
            log("hmmm");
            return true;
          }
        } else {
          return true;
        }
      } else {
        if (!(await Permission.storage.isGranted)) {
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

  Future<(List<AudioMetadata>, List<Album>, List<Artist>)?>
      fetchAudios() async {
    try {
      if (await requestStoragePermission()) {
        return await fetchMp3s();
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<(List<AudioMetadata>, List<Album>, List<Artist>)> fetchMp3s() async {
    const String downloadsDirectoryPath = "/storage/emulated/0";

    final Directory downloadsDirectory = Directory(downloadsDirectoryPath);
    List<AudioMetadata> foundMp3s = [];
    List<Album> albums = [];
    List<Artist> artists = [];
    Map<String, List<AudioMetadata>> albumKeys = {};
    Map<String, List<AudioMetadata>> artistMap = {};
    try {
      if (await downloadsDirectory.exists()) {
        final entities = await downloadsDirectory.list().toList();
        entities.removeWhere((e) => e.path == "/storage/emulated/0/Android");
        await Future.forEach(entities, (entity) async {
          try {
            if (entity is Directory) {
              final subEntities = await entity.list(recursive: true).toList();
              await Future.forEach(subEntities, (element) async {
                if (element is File && element.path.endsWith('.mp3')) {
                  try {
                    final metadata =
                        readMetadata(File(element.path), getImage: true);
                    log('$metadata');
                    if (metadata.album != null) {
                      albumKeys.update(
                        metadata.album!,
                        (val) => val..add(metadata),
                        ifAbsent: () => [metadata],
                      );
                    } else {
                      albumKeys.update(
                        "Unknown Album",
                        (val) => val..add(metadata),
                        ifAbsent: () => [metadata],
                      );
                    }
                    if (metadata.artist != null) {
                      artistMap.update(
                        metadata.artist!,
                        (val) => val..add(metadata),
                        ifAbsent: () => [metadata],
                      );
                    }
                    foundMp3s.add(metadata);
                  } catch (e) {
                    log('Error reading metadata: $e');
                  }
                }
              });
            }
            if (entity is File && entity.path.endsWith('.mp3')) {
              try {
                final metadata =
                    readMetadata(File(entity.path), getImage: true);
                if (metadata.album != null) {
                  albumKeys.update(
                    metadata.album!,
                    (val) => val..add(metadata),
                    ifAbsent: () => [metadata],
                  );
                }
                if (metadata.artist != null) {
                  artistMap.update(
                    metadata.artist!,
                    (val) => val..add(metadata),
                    ifAbsent: () => [metadata],
                  );
                }
                foundMp3s.add(metadata);
              } catch (e) {
                log('Error reading metadata: $e');
              }
            }
          } catch (e) {
            log('Error accessing entity: ${entity.path}, $e');
          }
        });
        albumKeys.forEach((key, value) {
          albums.add(
            Album(
              name: key,
              author: value.first.artist ?? "Unknown",
              songs: value,
            ),
          );
        });
        artistMap.forEach((key, value) {
          artists.add(
            Artist(
              name: key,
              songs: value.length,
              albums: getAlbumCount(key, foundMp3s),
              audios: value,
            ),
          );
        });
        return (foundMp3s, albums, artists);
      } else {
        const statusMessage =
            "Downloads directory not found at $downloadsDirectoryPath";
        log(statusMessage);
        throw Exception("An Error Occurred");
      }
    } catch (e) {
      final statusMessage = "Error reading directory: $e";
      log(statusMessage);
      throw Exception("Error Occurred while fetching audio");
    }
  }

  int getAlbumCount(String artist, List<AudioMetadata> audios) {
    int count = 0;
    for (var element in audios) {
      if (element.artist == artist) {
        count++;
      }
    }
    return count;
  }
}

class Album {
  String? name;
  String? author;
  List<AudioMetadata> songs;

  Album({this.name, this.author, required this.songs});
}

class Artist {
  String? name;
  int songs;
  int albums;
  List<AudioMetadata> audios;

  Artist({
    required this.name,
    required this.songs,
    required this.albums,
    required this.audios,
  });
}
