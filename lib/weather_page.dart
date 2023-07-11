import 'package:flutter/material.dart';
import 'package:yumemi_weather/yumemi_weather.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

// 天気の情報を受け渡しProvider
final weatherProvider = StateProvider((ref) => '');

class WeatherPage extends ConsumerWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wether = ref.watch(weatherProvider);

    void showErrorDialog() {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: const Text('Error'),
                content: const Text('仮のテキスト'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              )));
    }

    void fetchWeather() async {
      final yumemiWeather = YumemiWeather();
      try {
        final weatherCondition = yumemiWeather.fetchThrowsWeather('tokyo');
        // 更新
        ref.read(weatherProvider.notifier).state = weatherCondition;
      } catch (e) {
        showErrorDialog();
      }
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
              child: wether == ''
                  ? const Placeholder()
                  : SvgPicture.asset(
                      'assets/$wether.svg',
                    ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              width: temperatureBoxWidth,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "** ℃",
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
