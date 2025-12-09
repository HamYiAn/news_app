import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailController extends GetxController {
  Future<void> openArticle(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          'Error',
          'Could not launch the article',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to open article: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
