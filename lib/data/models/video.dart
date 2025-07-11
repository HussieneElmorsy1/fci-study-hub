// lib/data/models/video.dart
class Video {
  final String id;
  final String title;
  final String url;
  final String thumbnail;
  final String? description;

  Video(this.description, {
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnail,
  });
}