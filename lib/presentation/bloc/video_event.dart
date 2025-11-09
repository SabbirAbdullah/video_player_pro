

import '../../domain/entities/video_entity.dart';
import 'package:equatable/equatable.dart';

abstract class VideoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadVideosEvent extends VideoEvent {}
