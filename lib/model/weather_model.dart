import 'dart:convert';

import 'package:flutter/foundation.dart';

class WeatherModel {
  final String condition;
  final int maxTemperature;
  final int minTemperature;

  WeatherModel({
    required this.condition,
    required this.maxTemperature,
    required this.minTemperature,
  });

  factory WeatherModel.formData(dynamic data) {
    var decode = jsonDecode(data);
    final condition = decode['weather_condition'];
    final maxTemperature = decode['max_temperature'];
    final minTemperature = decode['min_temperature'];

    final model = WeatherModel(
        condition: condition,
        maxTemperature: maxTemperature,
        minTemperature: minTemperature);

    return model;
  }
}
