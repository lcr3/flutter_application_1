import 'package:flutter/material.dart';
import 'package:yumemi_weather/yumemi_weather.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vector_graphics/vector_graphics.dart';

// 天気の情報を受け渡しProvider
final weatherProvider = StateProvider((ref) => '');

void main() {
  // プロバイダをウィジェットで利用するには、アプリ全体を
  // `ProviderScope` ウィジェットで囲む必要があります。
  // ここに各プロバイダのステート（状態）・値が格納されていきます。
  runApp(const ProviderScope(child: MyApp()));
}

enum WeatherType {
  sunny,
  cloudy,
  rainy,
}

void reload() {}

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wether = ref.watch(weatherProvider);

    void fetchWeather() async {
      final yumemiWeather = YumemiWeather();
      final weatherCondition = await yumemiWeather.fetchSimpleWeather();
      print('Weather Condition: $weatherCondition');

      // 更新
      ref.read(weatherProvider.notifier).state = weatherCondition;
    }

    //   // 画面の半分サイズ
    final double placeholderWidth = MediaQuery.of(context).size.width / 2;
    final double temperatureBoxWidth = placeholderWidth;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('タイトル'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: placeholderWidth,
              height: placeholderWidth,
              child: const Placeholder(),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              width: temperatureBoxWidth,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      wether,
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.fontWeight),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                      child: Text(
                    "** ℃",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight:
                            Theme.of(context).textTheme.labelLarge?.fontWeight),
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            ),
            Container(
              width: temperatureBoxWidth,
              padding: const EdgeInsets.only(top: 80),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                      ),
                      child: const Text(
                        'Close',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: fetchWeather,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                      ),
                      child: const Text(
                        'Reload',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
