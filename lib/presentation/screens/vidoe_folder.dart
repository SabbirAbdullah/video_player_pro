import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_pro/presentation/screens/video_screen.dart';


import '../bloc/video_event.dart';
import '../bloc/video_state.dart';
import '../bloc/vidoe_bloc.dart';




class FolderListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      BlocProvider.of<VideoBloc>(context)..add(LoadVideosEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Video Player Pro", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.redAccent,
        ),
        body: BlocBuilder<VideoBloc, VideoState>(
          builder: (context, state) {
            if (state is VideoLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is VideoError) {
              return Center(child: Text(state.message));
            }
            if (state is VideoLoaded) {
              final folders = state.folderVideos.keys.toList();
              return ListView.separated(
                padding: EdgeInsets.all(16),
                separatorBuilder: (_, __) => SizedBox(height: 12),
                itemCount: folders.length,
                itemBuilder: (context, index) {
                  final folderName = folders[index];
                  final videos = state.folderVideos[folderName]!;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FolderVideosScreen(
                            folderName: folderName,
                            videos: videos,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(Icons.folder, size: 50, color: Colors.redAccent),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  folderName,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text('${videos.length} videos',
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 14)),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
        backgroundColor: Colors.grey[100],
      ),
    );
  }
}
