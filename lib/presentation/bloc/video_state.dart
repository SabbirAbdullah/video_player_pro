
import '../../domain/entities/video_entity.dart';

import 'package:equatable/equatable.dart';
import '../../domain/entities/video_entity.dart';

abstract class VideoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoLoaded extends VideoState {
  final Map<String, List<VideoEntity>> folderVideos;
  VideoLoaded({required this.folderVideos});
  @override
  List<Object?> get props => [folderVideos];
}

class VideoError extends VideoState {
  final String message;
  VideoError({required this.message});
  @override
  List<Object?> get props => [message];
}
