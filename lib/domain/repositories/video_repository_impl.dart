import 'dart:io';
import 'package:path/path.dart' as p;
import '../../domain/entities/video_entity.dart';
import '../../domain/repositories/video_repository.dart' hide VideoEntity;
import 'package:permission_handler/permission_handler.dart';

class VideoRepositoryImpl implements VideoRepository {
  @override
  Future<Map<String, List<VideoEntity>>> getVideosByFolder() async {
    final status = await Permission.storage.request();
    if (!status.isGranted) throw Exception("Storage permission denied");

    Map<String, List<VideoEntity>> folderMap = {};

    final directories = [Directory('/storage/emulated/0/')]; // Android storage root
    for (var dir in directories) {
      if (dir.existsSync()) {
        final files = dir.listSync(recursive: true, followLinks: false);
        for (var file in files) {
          if (file is File && file.path.endsWith('.mp4')) {
            final folder = p.basename(file.parent.path);
            if (!folderMap.containsKey(folder)) folderMap[folder] = [];
            folderMap[folder]!.add(VideoEntity(
              path: file.path,
              name: p.basename(file.path),
              folder: folder,
            ));
          }
        }
      }
    }
    return folderMap;
  }
}
