import 'package:get/get.dart';
import '../../core/services/api_service.dart';
import '../../data/repositories/news_repository.dart';
import '../controllers/news_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Services
    Get.put(ApiService(), permanent: true);

    // Repositories
    Get.put(NewsRepository(), permanent: true);

    // Controllers
    Get.lazyPut(() => NewsController());
  }
}
