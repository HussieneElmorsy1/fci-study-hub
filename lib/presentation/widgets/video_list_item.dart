import 'package:fci_app_new/data/models/pdf_document.dart';
import 'package:fci_app_new/data/providers/document_provider.dart';
import 'package:fci_app_new/presentation/widgets/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class VideoListItem extends StatelessWidget {
  final PdfDocument document;
  final String collectionId;
  final bool isDarkMode;

  const VideoListItem({
    Key? key,
    required this.document,
    required this.collectionId,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final documentProvider = Provider.of<DocumentProvider>(context, listen: false);
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.1 : 0.05),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Get.to(() => VideoPlayerScreen(videoUrl: document.url));
        },
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            // Video thumbnail
            Container(
              width: 120,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Icon(
                    //   Icons.play_circle_fill,
                    //   size: 40,
                    //   color: Colors.blue[700],
                    // ),
                    Icon(
                      Icons.video_file,
                      size: 60,
                      color: Colors.blue[700],
                    ),
                  ],
                ),
              ),
            ),

            // Video details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      document.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Description
                    if (document.description != null && document.description!.isNotEmpty)
                      Text(
                        document.description!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    const SizedBox(height: 4),

                    // Date and actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Creation date
                        Text(
                          '${document.createdAt.day}/${document.createdAt.month}/${document.createdAt.year}',
                          style: TextStyle(
                            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          children: [
                            // Download icon
                            Icon(
                              document.isDownloaded ? Icons.download_done : Icons.download,
                              color: document.isDownloaded 
                                  ? Colors.green 
                                  : (isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            // Favorite icon
                            Icon(
                              document.isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: document.isFavorite 
                                  ? Colors.red 
                                  : (isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                              size: 18,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // More options button
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: theme.iconTheme.color,
              ),
              onPressed: () => _showOptionsBottomSheet(context, documentProvider, theme),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsBottomSheet(
    BuildContext context, 
    DocumentProvider documentProvider,
    ThemeData theme,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.cardColor,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Download/Delete option
              ListTile(
                leading: Icon(
                  document.isDownloaded ? Icons.delete : Icons.download,
                  color: document.isDownloaded ? Colors.red : theme.primaryColor,
                ),
                title: Text(
                  document.isDownloaded ? 'حذف التنزيل' : 'تنزيل للمشاهدة لاحقاً',
                  style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                ),
                onTap: () {
                  if (document.isDownloaded) {
                    documentProvider.removeDownloadedMark(collectionId, document.id);
                  } else {
                    documentProvider.markAsDownloaded(collectionId, document.id);
                  }
                  Get.back();
                },
              ),
              // Favorite option
              ListTile(
                leading: Icon(
                  document.isFavorite ? Icons.favorite_border : Icons.favorite,
                  color: document.isFavorite ? Colors.grey : Colors.red,
                ),
                title: Text(
                  document.isFavorite ? 'إزالة من المفضلة' : 'إضافة إلى المفضلة',
                  style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                ),
                onTap: () {
                  documentProvider.toggleFavorite(collectionId, document.id);
                  Get.back();
                },
              ),
              // Share option
              ListTile(
                leading: Icon(
                  Icons.share,
                  color: theme.primaryColor,
                ),
                title: Text(
                  'مشاركة',
                  style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                ),
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}