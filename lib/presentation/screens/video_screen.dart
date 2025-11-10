import 'package:flutter/material.dart';
import 'package:video_player_pro/presentation/screens/video_full_screen_view.dart';

import '../../domain/entities/video_entity.dart';



class FolderVideosScreen extends StatelessWidget {
  final String folderName;
  final List<VideoEntity> videos;

  FolderVideosScreen({required this.folderName, required this.videos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(folderName, style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.redAccent,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        itemCount: videos.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 16 / 9,
        ),
        itemBuilder: (context, index) {
          final video = videos[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VideoPlayerScreen(videoPath: video.path),
                ),
              );
            },
            child: Hero(
              tag: video.path,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage('assets/video.png'), // placeholder thumbnail
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12)),
                  ),
                  child: Text(
                    video.name,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}
