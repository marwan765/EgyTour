import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool isPasswordVisible = false;

  void _login() async {
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text.trim();

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم تسجيل الدخول بنجاح')),
      );
      Navigator.of(context).pushReplacementNamed('/home');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ: ${e.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/signup-login-page/login/WhatsApp Image 2025-02-01 at 23.40.06.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: _toggleButton('Existing', true, () {}),
                              ),
                              Expanded(
                                child: _toggleButton('New', false, () {
                                  Navigator.pushNamed(context, '/signup');
                                }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 50),
                        _customTextField(_emailCtrl, 'Email Address', Icons.email),
                        SizedBox(height: 15),
                        Divider(color: Colors.black, thickness: 1.2),
                        SizedBox(height: 15),
                        _customTextField(_passCtrl, 'Password', Icons.lock, isPassword: true),
                        SizedBox(height: 60),
                        ElevatedButton(
                          onPressed: _login,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color(0xFFFF6A19)),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 15)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: Text('Login',
                              style: TextStyle(fontSize: 18, color: Colors.black)),
                        ),
                        SizedBox(height: 20),
                        TextButton(
                          onPressed: () {},
                          child: Text('Forget Password?',
                              style:
                              TextStyle(color: Colors.black, fontSize: 16)),
                        ),
                        SizedBox(height: 20),
                        Text('or',
                            style:
                            TextStyle(color: Colors.black, fontSize: 16)),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _socialIconButton(Icons.facebook, Colors.blue),
                        SizedBox(width: 20),
                        _socialIconButton(Icons.g_translate, Colors.red),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleButton(
      String text, bool selected, VoidCallback onPressed) {
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color:
        selected ? Color(0xFFFF6A19).withOpacity(0.99) : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _customTextField(TextEditingController controller, String hintText,
      IconData icon,
      {bool isPassword = false}) {
    return Container(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Icon(icon, color: Colors.black),
          ),
          SizedBox(width: 20),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: isPassword && !isPasswordVisible,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.black),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
          if (isPassword)
            IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            ),
        ],
      ),
    );
  }

  Widget _socialIconButton(IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      padding: EdgeInsets.all(10),
      child: Icon(icon, color: Colors.black, size: 30),
    );
  }
}