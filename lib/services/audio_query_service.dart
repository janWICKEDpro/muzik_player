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
        final entities = downloadsDirectory.listSync().toList();
        entities.removeWhere((e) => e.path == "/storage/emulated/0/Android");
        for (var entity in entities) {
          if (entity is Directory) {
            entity.listSync(recursive: true).forEach((element) {
              if (element is File && element.path.endsWith('.mp3')) {
                final metadata =
                    readMetadata(File(element.path), getImage: true);
                log('$metadata');
                if (metadata.album != null) {
                  log('Got here');
                  albumKeys.update(
                    metadata.album!,
                    (val) {
                      final newList = val..add(metadata);
                      return newList;
                    },
                    ifAbsent: () => [metadata],
                  );
                }else {
                   albumKeys.update(
                    "Unkown Album",
                    (val) {
                      final newList = val..add(metadata);
                      return newList;
                    },
                    ifAbsent: () => [metadata],
                  );
                }
                if (metadata.artist != null) {
                  artistMap.update(
                    metadata.artist!,
                    (val) {
                      final newList = val..add(metadata);
                      return newList;
                    },
                    ifAbsent: () => [metadata],
                  );
                }
                foundMp3s.add(metadata);
              }
            });
          }
          if (entity is File) {
            final metadata = readMetadata(File(entity.path), getImage: true);
            if (metadata.album != null) {
              albumKeys.update(
                metadata.album!,
                (val) {
                  final newList = val..add(metadata);
                  return newList;
                },
                ifAbsent: () => [metadata],
              );
            }
            if (metadata.artist != null) {
              artistMap.update(
                metadata.artist!,
                (val) {
                  final newList = val..add(metadata);
                  return newList;
                },
                ifAbsent: () => [metadata],
              );
            }
            foundMp3s.add(metadata);
          }
        }
        for (var key in albumKeys.keys) {
          albums.add(
            Album(
                name: key,
                author: albumKeys[key]?.first.artist ?? "Unkown",
                songs: albumKeys[key] ?? []),
          );
        }
        for (var key in artistMap.keys) {
          artists.add(
            Artist(
                name: key,
                songs: albumKeys[key]?.length ?? 0,
                albums: getAlbumCount(key, foundMp3s),
                audios: albumKeys[key] ?? []),
          );
        }
        return (foundMp3s, albums, artists);
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
