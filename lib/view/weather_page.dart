import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/weather.dart';
import 'package:flutter_application_1/repository/weater_repository_provider.dart';
import 'package:yumemi_weather/yumemi_weather.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherPage extends ConsumerWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // weatherの内容に変化があるとウィジェットが更新される
    Weather weather = ref.watch(weatherProvider);

    void fetch() {
      ref.read(weatherProvider.notifier).fetch();
    }

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
              child: weather.condition == ''
                  ? const Placeholder()
                  : SvgPicture.asset(
                      'assets/${weather.condition}.svg',
                    ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              width: temperatureBoxWidth,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      weather.minTemperature == -99
                          ? "** ℃"
                          : weather.minTemperature.toString(),
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
                    weather.maxTemperature == -99
                        ? "** ℃"
                        : weather.maxTemperature.toString(),
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
                      onPressed: fetch,
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
