import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/starter_screen/backgroundproject.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Discover Egypt's\n",
                    style: TextStyle(
                      color: const Color(0xFF6A19).withOpacity(0.99),
                      fontSize: 40,
                      height: 60 / 48,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Oxanium',
                    ),
                  ),
                  TextSpan(
                    text: "Wonder",
                    style: TextStyle(
                      color: const Color(0xFF6A19).withOpacity(0.99),
                      fontSize: 40,
                      height: 60 / 48,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Oxanium',
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 80),
            const Text(
              "Explore Timeless\n Treasure\nAnd Vibrant\n Culture In The\nHeart Of Egypt",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.normal,
                fontFamily: 'Oxanium',
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            const Spacer(),
            Container(
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/signup',
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A19).withOpacity(0.99),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  'Get started',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Oxanium',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login',
                      (route) => false,
                    );
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: const Color(0xFF6A19).withOpacity(0.99),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ],
    );
  }
}