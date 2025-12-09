import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../data/models/news_model.dart';

class NewsCard extends StatelessWidget {
  final Article article;
  final VoidCallback? onTap;

  const NewsCard({Key? key, required this.article, this.onTap})
    : super(key: key);

  String? _extractEmail() {
    if (article.author != null && article.author!.contains('@')) {
      return article.author;
    }

    if (article.description != null) {
      final emailRegex = RegExp(
        r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b',
      );
      final match = emailRegex.firstMatch(article.description!);
      if (match != null) {
        return match.group(0);
      }
    }

    if (article.content != null) {
      final emailRegex = RegExp(
        r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b',
      );
      final match = emailRegex.firstMatch(article.content!);
      if (match != null) {
        return match.group(0);
      }
    }

    return null;
  }

  String _getAuthorDisplay() {
    final email = _extractEmail();
    if (email != null) {
      return email;
    }

    if (article.author != null && article.author!.isNotEmpty) {
      final names = article.author!.split(',')[0].trim();
      return names.split(' ')[0];
    }

    return 'Author';
  }

  String _getAuthorRole() {
    final email = _extractEmail();
    if (email != null) {
      return 'Email';
    }

    if (article.author != null && article.author!.isNotEmpty) {
      if (article.author!.toLowerCase().contains('reporter') ||
          article.author!.toLowerCase().contains('editor') ||
          article.author!.toLowerCase().contains('correspondent') ||
          article.author!.toLowerCase().contains('contributor')) {
        return 'Reporter';
      }

      if (article.author!.contains(',')) {
        final parts = article.author!.split(',');
        if (parts.length > 1) {
          return parts[1].trim();
        }
      }
    }

    return 'Author';
  }

  String _getAuthorInitials() {
    final authorDisplay = _getAuthorDisplay();

    if (authorDisplay.contains('@')) {
      return authorDisplay[0].toUpperCase();
    }

    if (authorDisplay.isNotEmpty) {
      return authorDisplay[0].toUpperCase();
    }

    return 'A';
  }

  @override
  Widget build(BuildContext context) {
    final authorDisplay = _getAuthorDisplay();
    final authorRole = _getAuthorRole();
    final authorInitials = _getAuthorInitials();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage!,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                      size: 50,
                    ),
                  ),
                ),
              )
            else
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: const Icon(Icons.article, color: Colors.grey, size: 50),
              ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        article.source?.name ?? 'Unknown Source',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF2196F3),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '|',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        article.formattedDate,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  if (article.description != null &&
                      article.description!.isNotEmpty)
                    Text(
                      article.description!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF2196F3),
                                width: 1.5,
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Text(
                                authorInitials,
                                style: const TextStyle(
                                  color: Color(0xFF2196F3),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                authorDisplay,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                authorRole,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      TextButton(
                        onPressed: onTap,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                        ),
                        child: const Row(
                          children: [
                            Text(
                              'Read More',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2196F3),
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Color(0xFF2196F3),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
