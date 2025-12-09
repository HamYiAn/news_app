import 'package:get/get.dart';
import '../controllers/news_detail_controller.dart';

class NewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewsDetailController());
  }
}
