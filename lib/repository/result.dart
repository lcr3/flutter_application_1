import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

// swiftでお馴染みResultクラス
@freezed
class Result<T> with _$Result<T> {
  const Result._();
  const factory Result.success({required T data}) = Success<T>;
  const factory Result.failure({required String message}) = Failure<T>;

  static Result<T> guard<T>(T Function() body) {
    try {
      return Result.success(
        data: body(),
      );
    } on Exception catch (error) {
      return Result.failure(
        message: error.toString(),
      );
    }
  }
}

// https://zenn.dev/muttsu_623/articles/b928bad493a2c7f8b32f えらーくらす