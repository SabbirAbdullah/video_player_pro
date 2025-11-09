import '../entities/video_entity.dart';

abstract class VideoRepository {
  Future<Map<String, List<VideoEntity>>> getVideosByFolder();
}
