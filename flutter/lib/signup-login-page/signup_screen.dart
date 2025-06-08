import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isExistingUser = false;

  // تحديد الإيميلات المسموح لها
  // final allowedEmails = ['email1@example.com', 'email2@example.com', 'ziad46333@gmial.com'];

  Future<void> _register() async {
    final name = _nameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text.trim();
    final confirm = _confirmCtrl.text.trim();

    if (pass != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('كلمتا المرور غير متطابقتين')),
      );
      return;
    }

    // if (!allowedEmails.contains(email)) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('البريد الإلكتروني غير مسموح به')),
    //   );
    //   return;
    // }

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم التسجيل بنجاح')),
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
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
                          child: _toggleButton('Existing', isExistingUser, () {
                            setState(() {
                              isExistingUser = true;
                            });
                            Navigator.pushNamed(context, '/login');
                          }),
                        ),
                        Expanded(
                          child: _toggleButton('New', !isExistingUser, () {
                            setState(() {
                              isExistingUser = false;
                            });
                          }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  _customTextField(controller: _nameCtrl, hintText: 'Name', icon: Icons.person),
                  SizedBox(height: 10),
                  Divider(color: Colors.black, thickness: 1.2),
                  SizedBox(height: 10),
                  _customTextField(controller: _emailCtrl, hintText: 'Email Address', icon: Icons.email),
                  SizedBox(height: 10),
                  Divider(color: Colors.black, thickness: 1.2),
                  SizedBox(height: 10),
                  _customTextField(
                    controller: _passCtrl,
                    hintText: 'Password',
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                  SizedBox(height: 10),
                  Divider(color: Colors.black, thickness: 1.2),
                  SizedBox(height: 10),
                  _customTextField(
                    controller: _confirmCtrl,
                    hintText: 'Confirmation',
                    icon: Icons.lock,
                    isPassword: true,
                    isConfirm: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _register,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFFFF6A19)),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 100, vertical: 15)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Text('SignUp', style: TextStyle(fontSize: 18, color: Colors.black)),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        child: Divider(color: Colors.black, thickness: 0.6),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('OR', style: TextStyle(color: Colors.black, fontSize: 16)),
                      ),
                      Container(
                        width: 50,
                        child: Divider(color: Colors.black, thickness: 0.6),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 70),
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

  Widget _toggleButton(String text, bool selected, VoidCallback onPressed) {
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: selected ? Color(0xFFFF6A19).withOpacity(0.99) : Colors.transparent,
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

  Widget _customTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    bool isConfirm = false,
  }) {
    bool obscure = false;
    if (isPassword) {
      obscure = isConfirm ? !isConfirmPasswordVisible : !isPasswordVisible;
    }

    return Container(
      height: 50,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
      Padding(
      padding: const EdgeInsets.only(left: 10, right: 15),
      child: Icon(icon, color: Colors.black),
    ),
    Expanded(
    child: TextField(
    controller: controller,
    obscureText: obscure,
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
    obscure ? Icons.visibility_off : Icons.visibility,
    color: Colors.black,
    ),
    onPressed: () {
    setState(() {
    if (isConfirm) {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    } else {
    isPasswordVisible = !isPasswordVisible;
    }
    });
    },
    ),
    ],
    ),
    );
    }

  Widget _socialIconButton(IconData icon, Color color) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        padding: EdgeInsets.all(10),
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }
}