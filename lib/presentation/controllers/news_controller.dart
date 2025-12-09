import 'package:get/get.dart';
import '../../data/models/news_model.dart';
import '../../data/repositories/news_repository.dart';

class NewsController extends GetxController {
  final NewsRepository _newsRepository = Get.find<NewsRepository>();

  final RxList<Article> articles = <Article>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool hasError = false.obs;

  final RxInt currentPage = 1.obs;
  final RxBool hasMoreData = true.obs;
  final RxBool isLoadingMore = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTopHeadlines();
  }

  Future<void> fetchTopHeadlines({bool refresh = false}) async {
    try {
      if (refresh) {
        currentPage.value = 1;
        hasMoreData.value = true;
      }

      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      if (refresh) {
        articles.clear();
      }

      final response = await _newsRepository.getTopHeadlines(
        page: currentPage.value,
      );

      if (response.articles.isEmpty) {
        hasMoreData.value = false;
      } else {
        articles.addAll(response.articles);
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      hasError.value = true;
      errorMessage.value = e.toString();
    }
  }

  Future<void> loadMoreNews() async {
    if (isLoadingMore.value || !hasMoreData.value) return;

    try {
      isLoadingMore.value = true;
      currentPage.value++;

      final response = await _newsRepository.getTopHeadlines(
        page: currentPage.value,
      );

      if (response.articles.isEmpty) {
        hasMoreData.value = false;
      } else {
        articles.addAll(response.articles);
      }

      isLoadingMore.value = false;
    } catch (e) {
      isLoadingMore.value = false;
      currentPage.value--;
    }
  }

  Future<void> refreshNews() async {
    await fetchTopHeadlines(refresh: true);
  }

  Future<void> searchNews(String query) async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';
      articles.clear();

      final response = await _newsRepository.searchNews(query: query);

      if (response.articles.isNotEmpty) {
        articles.assignAll(response.articles);
      } else {
        hasError.value = true;
        errorMessage.value = 'No news found for "$query"';
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      hasError.value = true;
      errorMessage.value = 'Failed to search news: $e';
    }
  }

  void clearSearch() {
    fetchTopHeadlines(refresh: true);
  }
}
