import 'package:flutter_application_1/uistate/ui_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/repository/whether_repository.dart';

final fetchWeatherUseCaseProvider = Provider<WeatherUseCase>((ref) {
  final repository = ref.watch(weatherRepositoryProvider);

  return WeatherUseCase(
    ref: ref,
    repository: repository,
  );
});

// WeatherRepository: Repositoryを呼び出し、取得結果に応じて各種Providerを更新します。
// WeatherMoodUseCaseProviderで管理します。
class WeatherUseCase {
  WeatherUseCase({
    required Ref ref,
    required WeatherRepository repository,
  })  : _ref = ref,
        _repository = repository;

  final Ref _ref;
  final WeatherRepository _repository;

  void call() {
    final result = _repository.fetchWeather();
    result.when(
      success: (weather) {
        _ref.read(weatherPageUiStateProvider.notifier).update(
              (state) => WeatherPageUiState.data(weather),
            );
      },
      failure: (error) {
        _ref.read(weatherPageUiStateProvider.notifier).update(
              (state) => const WeatherPageUiState.error('error'),
            );
      },
    );
  }
}
