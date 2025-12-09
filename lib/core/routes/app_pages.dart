import 'package:get/get.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/splash_page.dart';
import '../../presentation/pages/login_page.dart';
import '../../presentation/pages/news_page.dart';
import '../../presentation/pages/news_detail_page.dart';
import '../../presentation/pages/profile_page.dart';

import '../../presentation/bindings/news_binding.dart';

class AppPages {
  static final routes = [
    GetPage(name: '/splash', page: () => SplashPage()),
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: '/home', page: () => HomePage()),
    GetPage(name: '/news', page: () => NewsPage()),

    GetPage(
      name: '/news-detail',
      page: () => NewsDetailPage(article: Get.arguments),
      binding: NewsBinding(),
    ),

    GetPage(name: '/profile', page: () => ProfilePage()),
  ];
}
