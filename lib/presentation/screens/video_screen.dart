// lib/presentation/screens/video_screen.dart
import 'package:fci_app_new/data/providers/document_provider.dart';
import 'package:fci_app_new/presentation/widgets/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../widgets/video_list_item.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<DocumentProvider>(context, listen: false).getVideos();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            'قائمة الفيديوهات',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 0.5,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () => Get.back(),
          ),
        ),
        body: Consumer<DocumentProvider>(
          builder: (context, documentProvider, child) {
            if (documentProvider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (documentProvider.error != null) {
              return Center(
                child: Text(
                  documentProvider.error!,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              );
            }

            final videos = documentProvider.videos;

            if (videos.isEmpty) {
              return Center(
                child: Text(
                  'لا توجد فيديوهات متاحة',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => VideoPlayerScreen(videoUrl: video.url));
                  },
                  child: VideoListItem(
                    document: video,
                    collectionId: 'فيديو',
                    isDarkMode: isDarkMode,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}