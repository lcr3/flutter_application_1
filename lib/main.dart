import 'package:flutter/material.dart';
import 'package:flutter_application_1/start_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {
  // プロバイダをウィジェットで利用するには、アプリ全体を
  // `ProviderScope` ウィジェットで囲む必要があります。
  // ここに各プロバイダのステート（状態）・値が格納されていきます。
  runApp(const ProviderScope(child: MyApp()));
}

// StatelessWidget の代わりに Riverpod の ConsumerWidget を継承します。
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StartPage(),
    );
  }
}