import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  @JsonKey(name: 'weather_condition')
  final String condition;
  @JsonKey(name: 'max_temperature')
  final int maxTemperature;
  @JsonKey(name: 'min_temperature')
  final int minTemperature;

  Weather({
    required this.condition,
    required this.maxTemperature,
    required this.minTemperature,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}
