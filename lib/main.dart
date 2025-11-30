import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:video_player_pro/presentation/bloc/vidoe_bloc.dart';
import 'package:video_player_pro/presentation/screens/vidoe_folder.dart';
import 'domain/repositories/video_repository.dart';
import 'domain/repositories/video_repository_impl.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MediaStore.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final VideoRepository videoRepository = VideoRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<VideoRepository>(
      create: (_) => videoRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<VideoBloc>(
            create: (context) => VideoBloc(repository: videoRepository),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Video Player App',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: FolderListScreen(),
        ),
      ),
    );
  }
}

