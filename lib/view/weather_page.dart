import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/uistate/ui_state.dart';
import 'package:flutter_application_1/usecase/weather_usecase.dart';
import 'package:yumemi_weather/yumemi_weather.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherPage extends ConsumerWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(weatherPageUiStateProvider);

    void fetch() {
      ref.read(fetchWeatherUseCaseProvider).call();
    }

    void showErrorDialog() {
      // TODO: もっといいソリューションがないか
      // https://stackoverflow.com/questions/64636590/flutter-showdialog-setstate-or-markneedsbuild-called-during-build
      SchedulerBinding.instance.addPostFrameCallback((_) {
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
      });
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
              child: uiState.when(
                initial: () => const Placeholder(),
                data: (weather) => SvgPicture.asset(
                  'assets/${weather.condition}.svg',
                ),
                error: (message) {
                  showErrorDialog();
                  return const Placeholder();
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              width: temperatureBoxWidth,
              child: Row(
                children: [
                  Expanded(
                    child: uiState.when(
                      initial: () => Text(
                        "** ℃",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.fontWeight),
                        textAlign: TextAlign.center,
                      ),
                      data: (weather) => Text(
                        weather.minTemperature.toString(),
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.fontWeight),
                        textAlign: TextAlign.center,
                      ),
                      error: (message) {
                        return const Text('Error');
                      },
                    ),
                  ),
                  Expanded(
                    child: uiState.when(
                      initial: () => Text(
                        "** ℃",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.fontWeight),
                        textAlign: TextAlign.center,
                      ),
                      data: (weather) => Text(
                        weather.maxTemperature.toString(),
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.fontWeight),
                        textAlign: TextAlign.center,
                      ),
                      error: (message) {
                        return const Text('Error');
                      },
                    ),
                  ),
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
