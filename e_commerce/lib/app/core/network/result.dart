/// A generic class representing the result of an operation.
/// It can be either a [Success] or a [Failure].
sealed class Result<T, E> {
  const Result();

  /// Returns true if the result is a [Success].
  bool get isSuccess => this is Success<T, E>;

  /// Returns true if the result is a [Failure].
  bool get isFailure => this is Failure<T, E>;

  /// Convenience method to get success data or null.
  T? get dataOrNull => switch (this) {
        Success(data: final d) => d,
        Failure() => null,
      };

  /// Convenience method to get failure error or null.
  E? get errorOrNull => switch (this) {
        Success() => null,
        Failure(error: final e) => e,
      };
}

/// Represents a successful operation result.
class Success<T, E> extends Result<T, E> {
  final T data;
  const Success(this.data);
}

/// Represents a failed operation result.
class Failure<T, E> extends Result<T, E> {
  final E error;
  const Failure(this.error);
}