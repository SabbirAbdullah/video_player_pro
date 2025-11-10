import 'package:photo_manager/photo_manager.dart';
import '../../domain/entities/video_entity.dart';
import '../../domain/repositories/video_repository.dart';
import 'package:path/path.dart' as p;

class VideoRepositoryImpl implements VideoRepository {
  @override
  Future<Map<String, List<VideoEntity>>> getVideosByFolder() async {
    final permitted = await PhotoManager.requestPermissionExtend();
    if (!permitted.isAuth) {
      throw Exception("Permission denied");
    }

    // Fetch all video assets
    final List<AssetPathEntity> pathList = await PhotoManager.getAssetPathList(
      onlyAll: false,
      type: RequestType.video,
    );

    Map<String, List<VideoEntity>> folderMap = {};

    for (final pathEntity in pathList) {
      final folderName = pathEntity.name;
      final List<AssetEntity> assetList =
      await pathEntity.getAssetListPaged(page: 0, size: await pathEntity.assetCountAsync);

      for (final asset in assetList) {
        final file = await asset.file;
        if (file != null) {
          final path = file.path;
          folderMap.putIfAbsent(folderName, () => []);
          folderMap[folderName]!.add(
            VideoEntity(
              path: path,
              name: p.basename(path),
              folder: folderName,
            ),
          );
        }
      }
    }

    return folderMap;
  }
}
