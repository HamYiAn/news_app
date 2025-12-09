import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_page.dart';
import '../controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _loginController = Get.put(LoginController());
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _emailError;
  String? _passwordError;

  void _login() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty) {
      setState(() {
        _emailError = 'Please fill in all these fields';
      });
      _showErrorSnackbar('Please fill in all these fields');
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      setState(() {
        _emailError = 'Please enter a valid email address';
      });
      _showErrorSnackbar('Please enter a valid email address');
      return;
    }

    if (password.isEmpty) {
      setState(() {
        _passwordError = 'Please fill in all these fields';
      });
      _showErrorSnackbar('Please fill in all these fields');
      return;
    }

    if (password.length < 8) {
      setState(() {
        _passwordError = 'Password must be at least 8 characters';
      });
      _showErrorSnackbar('Password must be at least 8 characters');
      return;
    }

    bool emailRegistered = _loginController.registeredAccounts.any(
      (account) => account['email']!.toLowerCase() == email.toLowerCase(),
    );

    if (!emailRegistered) {
      setState(() {
        _emailError = 'Email tidak terdaftar';
      });
      _showErrorSnackbar('Email tidak terdaftar');
      return;
    }

    var account = _loginController.registeredAccounts.firstWhere(
      (acc) => acc['email']!.toLowerCase() == email.toLowerCase(),
      orElse: () => {'email': '', 'password': ''},
    );

    if (account['password'] != password) {
      setState(() {
        _passwordError = 'Password salah';
      });
      _showErrorSnackbar('Password salah');
      return;
    }

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isLoading = false);

    Get.off(() => HomePage());

    Get.snackbar(
      'Login Successful',
      'Welcome to RAGDANews!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Login Failed',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(10),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1557683316-973673baf926?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80',
                    ),
                    fit: BoxFit.cover,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue.withOpacity(0.8),
                      Colors.indigo.withOpacity(0.9),
                    ],
                  ),
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  padding: EdgeInsets.all(24),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'RAGDANews',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 1.0,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 4,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Please log into your account',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.95),
                            fontWeight: FontWeight.w400,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.4),
                                blurRadius: 3,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 8),

                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (_) {
                            if (_emailError != null) {
                              setState(() {
                                _emailError = null;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Cth. contoh@gmail.com',
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: _emailError != null
                                    ? Colors.red
                                    : Colors.grey[300]!,
                                width: _emailError != null ? 1.5 : 1.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: _emailError != null
                                    ? Colors.red
                                    : Colors.grey[300]!,
                                width: _emailError != null ? 1.5 : 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: _emailError != null
                                    ? Colors.red
                                    : Colors.blue,
                                width: _emailError != null ? 1.5 : 1.5,
                              ),
                            ),
                            filled: true,
                            fillColor: _emailError != null
                                ? Colors.red.withOpacity(0.05)
                                : Colors.grey[50],
                            prefixIcon: Icon(
                              Icons.person,
                              color: _emailError != null
                                  ? Colors.red
                                  : Colors.grey[600],
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                        ),

                        if (_emailError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_drop_up,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Email',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),

                                Container(
                                  margin: EdgeInsets.only(left: 24, top: 4),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.red.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _emailError!,
                                        style: TextStyle(
                                          color: Colors.red[700],
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Cth. user1@gmail.com',
                                        style: TextStyle(
                                          color: Colors.red[600],
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),

                    SizedBox(height: _emailError != null ? 20 : 24),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 8),

                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          onChanged: (_) {
                            if (_passwordError != null) {
                              setState(() {
                                _passwordError = null;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter password',
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: _passwordError != null
                                    ? Colors.red
                                    : Colors.grey[300]!,
                                width: _passwordError != null ? 1.5 : 1.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: _passwordError != null
                                    ? Colors.red
                                    : Colors.grey[300]!,
                                width: _passwordError != null ? 1.5 : 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: _passwordError != null
                                    ? Colors.red
                                    : Colors.blue,
                                width: _passwordError != null ? 1.5 : 1.5,
                              ),
                            ),
                            filled: true,
                            fillColor: _passwordError != null
                                ? Colors.red.withOpacity(0.05)
                                : Colors.grey[50],
                            prefixIcon: Icon(
                              Icons.lock,
                              color: _passwordError != null
                                  ? Colors.red
                                  : Colors.grey[600],
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: _passwordError != null
                                    ? Colors.red
                                    : Colors.grey[600],
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                        ),

                        if (_passwordError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_drop_up,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Password',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),

                                Container(
                                  margin: EdgeInsets.only(left: 24, top: 4),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.red.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _passwordError!,
                                        style: TextStyle(
                                          color: Colors.red[700],
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Minimal 8 karakter',
                                        style: TextStyle(
                                          color: Colors.red[600],
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),

                    SizedBox(height: _passwordError != null ? 20 : 12),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Get.snackbar(
                            'Forgot Password',
                            'Feature coming soon!',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 40),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: _isLoading
                            ? SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(
                                    Colors.black,
                                  ),
                                ),
                              )
                            : Text(
                                'Enter',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
