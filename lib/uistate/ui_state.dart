import 'package:flutter_application_1/model/weather.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_state.freezed.dart';

// WeatherPageUiState: 実際に、取得したデータを表示する部分です。
// WeatherPageUiStateStateProviderで管理します。
// Panelにデータがあるかないか
// エラーの場合は、更新しない

@freezed
class WeatherPageUiState with _$WeatherPageUiState {
  const factory WeatherPageUiState.initial() = _Initial;
  const factory WeatherPageUiState.data(Weather weather) = _Data;
  const factory WeatherPageUiState.error(String message) = _Errors;
}

final weatherPageUiStateProvider = StateProvider<WeatherPageUiState>(
  (_) => const WeatherPageUiState.initial(),
);
