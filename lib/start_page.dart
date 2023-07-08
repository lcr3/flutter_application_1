import 'package:flutter/material.dart';
import 'package:flutter_application_1/weather_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  @override
  void initState() {
    // 描画完了のタイミング
    WidgetsBinding.instance.endOfFrame.then((_) async {
      await Future.delayed(Duration(microseconds: 500.toInt()));

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WeatherPage()),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
      ),
    );
  }
}
