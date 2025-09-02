import 'package:flutter_poc/core/localizations/failure/failure_localizations.dart';
import 'package:flutter_poc/core/navigator_key.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure_model.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  Failure._();

  factory Failure({
    required int statusCode,
    required String message,
    required String debugMessage,
  }) = _Failure;

  factory Failure.generic(String debugMessage) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      final localization = FailureLocalizations.of(context)!;

      return Failure(
        statusCode: 500,
        message: localization.tr("generic"),
        debugMessage: debugMessage,
      );
    }
    return Failure(
      statusCode: 500,
      message: "Error",
      debugMessage: debugMessage,
    );
  }

  factory Failure.cancel(String debugMessage) {
    final context = navigatorKey.currentContext;
    final localization = FailureLocalizations.of(context!)!;
    return Failure(
      statusCode: 600,
      message: localization.tr("canceled"),
      debugMessage: debugMessage,
    );
  }

  factory Failure.noInternet(String debugMessage) {
    final context = navigatorKey.currentContext;
    final localization = FailureLocalizations.of(context!)!;
    return Failure(
      statusCode: 601,
      message: localization.tr("noInternet"),
      debugMessage: debugMessage,
    );
  }
}
