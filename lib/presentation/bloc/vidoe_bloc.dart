import 'package:flutter_bloc/flutter_bloc.dart';
import 'video_event.dart';
import 'video_state.dart';
import '../../domain/repositories/video_repository.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository repository;

  VideoBloc({required this.repository}) : super(VideoInitial()) {
    on<LoadVideosEvent>((event, emit) async {
      emit(VideoLoading());
      try {
        final videos = await repository.getVideosByFolder();
        emit(VideoLoaded(folderVideos: videos));
      } catch (e) {
        emit(VideoError(message: e.toString()));
      }
    });
  }
}
