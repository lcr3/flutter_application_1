import 'dart:convert';
import 'package:flutter_application_1/model/weather.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

final weatherDataSourceProvider = Provider<WeatherDataSource>((_) {
  final client = YumemiWeather();
  return WeatherDataSource(
    client,
  );
});


// YumemiWeatherから取得したデータをWeatherに変換する
// WeatherDataSourceはProviderで管理する
class WeatherDataSource {
  const WeatherDataSource(
    this._client,
  );

  final YumemiWeather _client;

  Weather fetchWeather() {
    const jsonString = '''
      {
        "area": "kyoto",
        "date": "2020-04-01T12:00:00+09:00"
      }''';
    try {
      final weatherJson = _client.fetchWeather(jsonString);
      final model = Weather.fromJson(jsonDecode(weatherJson));
      return model;
    } on YumemiWeatherError {
      throw Exception('error');
    }
  }
}
