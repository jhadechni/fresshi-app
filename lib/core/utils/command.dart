import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresshi/core/utils/result.dart';

/// A Riverpod-compatible command that wraps an async action and exposes its
/// state as [AsyncValue]. Use inside a [Notifier] or [AsyncNotifier] to
/// trigger side-effect operations (e.g. form submit, delete, login).
///
/// Example:
/// ```dart
/// class LoginNotifier extends Notifier<AsyncValue<void>> {
///   @override
///   AsyncValue<void> build() => const AsyncValue.data(null);
///
///   Future<void> login(String email, String password) async {
///     state = await Command.run(() async {
///       final result = await ref.read(authRepositoryProvider).login(email, password);
///       return result.fold(
///         (failure) => Result.error(failure),
///         (_) => const Result.ok(null),
///       );
///     });
///   }
/// }
/// ```
abstract final class Command {
  /// Executes [action] and wraps the [Result] it returns into an [AsyncValue].
  ///
  /// - While running: returns [AsyncValue.loading].
  /// - On [Result.ok]: returns [AsyncValue.data].
  /// - On [Result.error]: returns [AsyncValue.error].
  static Future<AsyncValue<T>> run<T>(
    Future<Result<T>> Function() action,
  ) async {
    try {
      final result = await action();
      return result.when(
        ok: AsyncValue.data,
        onError: (e) => AsyncValue.error(e, StackTrace.current),
      );
    } catch (e, st) {
      return AsyncValue.error(e, st);
    }
  }
}
