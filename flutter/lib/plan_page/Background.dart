import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ColorFiltered(
        colorFilter: ColorFilter.matrix(
          _exposureMatrix(-0.20),
        ),
        child: Image.asset(
          "assets/images/plan-r.jpg",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  static List<double> _exposureMatrix(double exposure) {
    final double value = exposure * 255;
    return [
      1, 0, 0, 0, value,
      0, 1, 0, 0, value,
      0, 0, 1, 0, value,
      0, 0, 0, 1, 0,
    ];
  }
}
