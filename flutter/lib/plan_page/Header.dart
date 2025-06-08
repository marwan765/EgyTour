import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    // الحصول على المستخدم الحالي
    final user = FirebaseAuth.instance.currentUser;
    final userEmail = user?.email ?? 'غير مسجل';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const BackButton(color: Colors.white),
        const Text(
          "My Plans",
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'AbrilFatface',
            color: Colors.white,
          ),
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.account_circle, color: Colors.white),
          onSelected: (value) async {
            if (value == 'logout') {
              // إظهار مؤشر تحميل
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(child: CircularProgressIndicator()),
              );

              try {
                // تسجيل الخروج
                await FirebaseAuth.instance.signOut();

                // التأكد من نجاح تسجيل الخروج
                if (FirebaseAuth.instance.currentUser == null) {
                  // إغلاق مؤشر التحميل
                  Navigator.pop(context);

                  // تأخير التنقل لتجنب قفل النافيغيشن
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                          (Route<dynamic> route) => false,
                    );
                  });
                } else {
                  // إغلاق مؤشر التحميل
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('فشل تسجيل الخروج، حاول مرة أخرى')),
                  );
                }
              } catch (e) {
                // إغلاق مؤشر التحميل
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('خطأ أثناء تسجيل الخروج: $e')),
                );
                print('خطأ تسجيل الخروج: $e');
              }
            }
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem<String>(
              enabled: false,
              child: Text(
                'البريد الإلكتروني: $userEmail',
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'logout',
              child: Text(
                'تسجيل الخروج',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ],
    );
  }
}