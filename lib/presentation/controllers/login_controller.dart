import 'package:get/get.dart';

class LoginController extends GetxController {
  final List<Map<String, String>> registeredAccounts = [
    {'email': 'user1@gmail.com', 'password': 'password123'},
    {'email': 'user2@gmail.com', 'password': 'password123'},
    {'email': 'user3@gmail.com', 'password': 'password123'},
  ];

  String? validateLogin(String email, String password) {
    if (email.isEmpty && password.isEmpty) {
      return 'Please fill in all these fields';
    }

    if (email.isEmpty) {
      return 'Email\nCth. contoh@gmail.com\n\nPlease fill in all these fields';
    }

    if (password.isEmpty) {
      return 'Enter password\n\nPlease fill in all these fields';
    }

    if (!email.contains('@') || !email.contains('.')) {
      return 'Please enter a valid email address';
    }

    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }

    bool emailRegistered = registeredAccounts.any(
      (account) => account['email']!.toLowerCase() == email.toLowerCase(),
    );

    if (!emailRegistered) {
      return 'Email tidak terdaftar';
    }

    var account = registeredAccounts.firstWhere(
      (acc) => acc['email']!.toLowerCase() == email.toLowerCase(),
      orElse: () => {'email': '', 'password': ''},
    );

    if (account['password'] != password) {
      return 'Password salah';
    }

    return null;
  }
}
