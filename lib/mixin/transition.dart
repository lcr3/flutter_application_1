
import 'package:flutter/material.dart';
import '../weather_page.dart';

mixin Transition {
  Future<void> delayTransition(BuildContext context) async {
    await Future.delayed(Duration(microseconds: 500.toInt()));

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WeatherPage()),
        );
      }
  }
}
