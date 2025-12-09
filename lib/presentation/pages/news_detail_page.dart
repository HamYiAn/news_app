import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import '../../data/models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailPage extends StatefulWidget {
  final Article article;

  const NewsDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initializeWebViewController();
  }

  void _initializeWebViewController() {
    if (widget.article.url != null && widget.article.url!.isNotEmpty) {
      final WebViewController controller = WebViewController();

      if (controller.platform is AndroidWebViewController) {
        (controller.platform as AndroidWebViewController)
            .setMediaPlaybackRequiresUserGesture(false);
      }

      controller.loadRequest(Uri.parse(widget.article.url!));

      controller.setJavaScriptMode(JavaScriptMode.unrestricted);

      _webViewController = controller;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: BoxDecoration(
              color: const Color(0xFF2196F3),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Detail News',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  color: const Color(0xFF2196F3),
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.white,
                    indicatorWeight: 3.0,
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    tabs: const [
                      Tab(text: 'DETAIL'),
                      Tab(text: 'WEB VIEW'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildDetailContent(), _buildWebView()],
            ),
          ),
        ],
      ),

      floatingActionButton:
          _tabController.index == 1 &&
              widget.article.url != null &&
              widget.article.url!.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                _openInBrowser();
              },
              backgroundColor: const Color(0xFF2196F3),
              child: const Icon(Icons.open_in_browser, color: Colors.white),
            )
          : null,
    );
  }

  Widget _buildDetailContent() {
    final authorDisplay = _getAuthorDisplay();
    final authorRole = _getAuthorRole();
    final authorInitials = _getAuthorInitials();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.article.source?.name ?? 'Unknown Source',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF2196F3),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                '|',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(width: 8),
              Text(
                widget.article.formattedDate,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            widget.article.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 12),

          if (widget.article.description != null &&
              widget.article.description!.isNotEmpty)
            Text(
              widget.article.description!,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.6,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF2196F3),
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Text(
                      authorInitials,
                      style: const TextStyle(
                        color: Color(0xFF2196F3),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authorDisplay,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        authorRole,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          if (widget.article.urlToImage != null &&
              widget.article.urlToImage!.isNotEmpty)
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(widget.article.urlToImage!),
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.article, color: Colors.grey, size: 50),
                  SizedBox(height: 8),
                  Text(
                    'No Image Available',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 24),

          if (widget.article.content != null &&
              widget.article.content!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.article.content!
                      .replaceAll(RegExp(r'\[\+[0-9]+\s*chars\]$'), '')
                      .trim(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.6,
                  ),
                ),
              ],
            )
          else if (widget.article.description != null &&
              widget.article.description!.isNotEmpty)
            Text(
              widget.article.description!,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.6,
              ),
            )
          else
            const Text(
              'No content available for this article.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildWebView() {
    if (widget.article.url == null || widget.article.url!.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No URL available for this article',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return WebViewWidget(controller: _webViewController);
  }

  void _openInBrowser() async {
    if (widget.article.url == null || widget.article.url!.isEmpty) {
      Get.snackbar(
        'Error',
        'No URL available',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      final Uri url = Uri.parse(widget.article.url!);
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not open browser: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  String? _extractEmail() {
    if (widget.article.author != null && widget.article.author!.contains('@')) {
      return widget.article.author;
    }

    if (widget.article.description != null) {
      final emailRegex = RegExp(
        r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b',
      );
      final match = emailRegex.firstMatch(widget.article.description!);
      if (match != null) return match.group(0);
    }

    if (widget.article.content != null) {
      final emailRegex = RegExp(
        r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b',
      );
      final match = emailRegex.firstMatch(widget.article.content!);
      if (match != null) return match.group(0);
    }

    return null;
  }

  String _getAuthorDisplay() {
    final email = _extractEmail();
    if (email != null) return email;

    if (widget.article.author != null && widget.article.author!.isNotEmpty) {
      final names = widget.article.author!.split(',')[0].trim();
      return names.split(' ')[0];
    }

    return 'Author';
  }

  String _getAuthorRole() {
    final email = _extractEmail();
    if (email != null) return 'Email';

    if (widget.article.author != null && widget.article.author!.isNotEmpty) {
      if (widget.article.author!.toLowerCase().contains('reporter') ||
          widget.article.author!.toLowerCase().contains('editor') ||
          widget.article.author!.toLowerCase().contains('correspondent')) {
        return 'Reporter';
      }

      if (widget.article.author!.contains(',')) {
        final parts = widget.article.author!.split(',');
        if (parts.length > 1) return parts[1].trim();
      }
    }

    return 'Author';
  }

  String _getAuthorInitials() {
    final authorDisplay = _getAuthorDisplay();
    if (authorDisplay.contains('@')) return authorDisplay[0].toUpperCase();
    if (authorDisplay.isNotEmpty) return authorDisplay[0].toUpperCase();
    return 'A';
  }
}
