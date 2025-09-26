import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';

typedef Result<T> = Either<Failure, T>;
typedef FutureResult<T> = Future<Either<Failure, T>>;

extension ResultExtensions<T> on Result<T> {
  bool get isSuccess => isRight();
  bool get isFailure => isLeft();

  T? get data => fold((l) => null, (r) => r);
  Failure? get failure => fold((l) => l, (r) => null);

  T getOrElse(T defaultValue) => fold((l) => defaultValue, (r) => r);
  T getOrThrow() => fold((l) => throw l, (r) => r);

  Result<U> map<U>(U Function(T) mapper) {
    return fold((failure) => Left(failure), (data) => Right(mapper(data)));
  }

  Result<U> flatMap<U>(Result<U> Function(T) mapper) {
    return fold((failure) => Left(failure), (data) => mapper(data));
  }
}

extension FutureResultExtensions<T> on FutureResult<T> {
  Future<Result<U>> map<U>(U Function(T) mapper) async {
    final result = await this;
    return result.map(mapper);
  }

  Future<Result<U>> flatMap<U>(FutureResult<U> Function(T) mapper) async {
    final result = await this;
    return result.fold((failure) => Left(failure), (data) => mapper(data));
  }

  Future<T> getOrElse(T defaultValue) async {
    final result = await this;
    return result.fold((l) => defaultValue, (r) => r);
  }

  Future<T> getOrThrow() async {
    final result = await this;
    return result.getOrThrow();
  }
}

// Helper functions for creating results
Result<T> success<T>(T data) => Right(data);
Result<T> failure<T>(Failure failure) => Left(failure);

FutureResult<T> asyncSuccess<T>(T data) => Future.value(Right(data));
FutureResult<T> asyncFailure<T>(Failure failure) => Future.value(Left(failure));
