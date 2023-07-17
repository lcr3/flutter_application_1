import 'dart:convert';

import 'package:flutter_application_1/model/weather.dart';
import 'package:flutter_application_1/repository/result.dart';
import 'package:flutter_application_1/datasource/weather_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  final dataSource = ref.watch(weatherDataSourceProvider);
  return WeatherRepository(dataSource);
});

// DataSourceを呼び出し、その結果をResultクラスに変換する
// WeatherRepositoryはProviderで管理する
class WeatherRepository {
  WeatherRepository(this._dataSource);

  final WeatherDataSource _dataSource;

  Result<Weather> fetchWeather() {
    return Result.guard(
      () => _dataSource.fetchWeather(),
    );
  }
}
