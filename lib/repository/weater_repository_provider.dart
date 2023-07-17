import 'package:flutter_application_1/model/weather_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherNotifier extends StateNotifier<WeatherModel> {
  WeatherNotifier()
      : super(WeatherModel(
            condition: '', maxTemperature: -99, minTemperature: -99));

  void fetch() {
    final yumemiWeather = YumemiWeather();
    const jsonString = '''
      {
        "area": "tokyo",
        "date": "2020-04-01T12:00:00+09:00"
      }''';
    try {
      final weatherJson = yumemiWeather.fetchWeather(jsonString);
      final model = WeatherModel.formData(weatherJson);
      state = model;
    } catch (e) {
      // showErrorDialog();
    }
  }
}

// 最後に WeatherNotifier のインスタンスを値に持つ StateNotifierProvider を作成し、
// UI 側から Weatherを操作することを可能にします。
final weatherProvider =
    StateNotifierProvider<WeatherNotifier, WeatherModel>((ref) {
  return WeatherNotifier();
});
