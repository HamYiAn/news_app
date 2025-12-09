import 'package:get/get.dart';
import '../models/news_model.dart';
import '../../core/services/api_service.dart';
import '../../core/constants/api_constants.dart';

class NewsRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<NewsResponse> getTopHeadlines({
    String? country,
    String? category,
    int page = 1,
    int pageSize = ApiConstants.pageSize,
  }) async {
    try {
      final response = await _apiService.get(
        ApiConstants.topHeadlines,
        queryParameters: {
          'country': country ?? ApiConstants.country,
          'category': category ?? ApiConstants.category,
          'page': page,
          'pageSize': pageSize,
        },
      );

      if (response.statusCode == 200) {
        return NewsResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Failed to fetch news: $e');
    }
  }

  Future<NewsResponse> searchNews({
    required String query,
    int page = 1,
    int pageSize = ApiConstants.pageSize,
  }) async {
    try {
      final response = await _apiService.get(
        ApiConstants.everything,
        queryParameters: {
          'q': query,
          'page': page,
          'pageSize': pageSize,
          'sortBy': 'publishedAt',
          'language': 'en',
        },
      );

      if (response.statusCode == 200) {
        return NewsResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to search news');
      }
    } catch (e) {
      throw Exception('Failed to search news: $e');
    }
  }
}
