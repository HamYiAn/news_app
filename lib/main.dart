import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/core/routes/app_pages.dart';
import 'package:news_app/presentation/bindings/app_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      initialBinding: AppBinding(),

      getPages: AppPages.routes,
      initialRoute: '/splash',

      enableLog: true,
      logWriterCallback: (text, {isError = false}) {
        print('[GETX] $text');
      },
    );
  }
}
