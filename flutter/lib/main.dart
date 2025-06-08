import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project_3/home.dart';
import 'package:graduation_project_3/signup-login-page/login/Login.dart';
import 'package:graduation_project_3/signup-login-page/signup_screen.dart';
import 'package:graduation_project_3/starter_screen/Splash_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:graduation_project_3/signup-login-page/firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashOrHome(),
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

class SplashOrHome extends StatefulWidget {
  const SplashOrHome({super.key});

  @override
  _SplashOrHomeState createState() => _SplashOrHomeState();
}

class _SplashOrHomeState extends State<SplashOrHome> {
  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    // التحقق من حالة تسجيل الدخول
    final user = FirebaseAuth.instance.currentUser;

    if (isFirstLaunch) {
      // إذا كان التشغيل الأول، انتقل إلى SplashScreen
      await prefs.setBool('isFirstLaunch', false);
      Navigator.pushReplacementNamed(context, '/splash');
    } else if (user != null) {
      // إذا كان المستخدم مسجل الدخول، انتقل إلى Home
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // إذا لم يكن مسجل الدخول، انتقل إلى Login
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}