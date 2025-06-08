import 'package:flutter/material.dart';
import 'Splash_screen.dart'; // استيراد الصفحة الجديدة



class Starter_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(), // استخدام الصفحة الجديدة هنا
        // أضف المزيد من المسارات هنا حسب الحاجة
        '/nextPage': (context) => NextPage(), // صفحة جديدة، تأكد من إنشائها
        '/login': (context) => LoginPage(), // صفحة تسجيل الدخول، تأكد من إنشائها

      },
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Text('Welcome to the Next Page!'),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: Text('Please log in.'),
      ),
    );
  }
}