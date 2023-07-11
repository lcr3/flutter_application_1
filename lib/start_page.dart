import 'package:flutter/material.dart';
import 'package:flutter_application_1/mixin/transition.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => StartPageState();
}

class StartPageState extends State<StartPage> with Transition {
  @override
  void initState() {
    // 描画完了のタイミング
    WidgetsBinding.instance.endOfFrame.then((_) async {
      delayTransition(context);
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
