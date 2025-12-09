import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import '../widgets/news_card.dart';
import '../widgets/news_shimmer.dart';
import 'news_detail_page.dart';

class NewsPage extends StatelessWidget {
  NewsPage({Key? key}) : super(key: key);

  final NewsController newsController = Get.find<NewsController>();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16,
              left: 20,
              right: 20,
              bottom: 16,
            ),
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
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'News',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Breaking News',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showSearchDialog(context);
                  },
                  icon: const Icon(Icons.search, size: 24),
                ),
              ],
            ),
          ),

          Container(height: 1, color: Colors.grey[200]),

          Expanded(
            child: Obx(() {
              if (newsController.isLoading.value &&
                  newsController.articles.isEmpty) {
                return const NewsShimmer();
              }

              if (newsController.hasError.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 64,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error Loading News',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          newsController.errorMessage.value,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          newsController.refreshNews();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2196F3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Try Again',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (newsController.articles.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.article_outlined,
                        color: Colors.grey,
                        size: 64,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No News Available',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Check back later for updates',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  await newsController.refreshNews();
                },
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollEndNotification &&
                        scrollNotification.metrics.pixels ==
                            scrollNotification.metrics.maxScrollExtent &&
                        newsController.hasMoreData.value) {
                      newsController.loadMoreNews();
                    }
                    return false;
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount:
                        newsController.articles.length +
                        (newsController.hasMoreData.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == newsController.articles.length) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: newsController.isLoadingMore.value
                                ? const CircularProgressIndicator()
                                : Container(),
                          ),
                        );
                      }

                      final article = newsController.articles[index];
                      return NewsCard(
                        article: article,
                        onTap: () {
                          Get.to(
                            () => NewsDetailPage(article: article),
                            transition: Transition.cupertino,
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Search News'),
          content: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'Enter keywords...',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                searchController.clear();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (searchController.text.trim().isNotEmpty) {
                  Navigator.pop(context);
                  newsController.searchNews(searchController.text.trim());
                  searchController.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3),
              ),
              child: const Text(
                'Search',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
