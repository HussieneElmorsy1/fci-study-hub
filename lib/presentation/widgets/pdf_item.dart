import 'package:fci_app_new/data/models/pdf_document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PdfItem extends StatelessWidget {
  final PdfDocument document;
  final VoidCallback onTap;
  

  const PdfItem({
    super.key,
    required this.document,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // PDF Icon with red badge
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 70,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: SvgPicture.asset(
                  'assets/icons/pdf_icon.svg',
                  width: 70,
                  height: 80,
                ),
              ),
              // Add a download icon if needed
                if (!document.isDownloaded)
                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.download,
                    color: Colors.white,
                    size: 12,
                  ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 5),
          // Document title
          Text(
            document.title,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}