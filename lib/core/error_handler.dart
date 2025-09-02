import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poc/core/localizations/failure/failure_localizations.dart';
import 'package:flutter_poc/core/navigator_key.dart';
import 'package:flutter_poc/domain/models/utils/failure_model.dart';

abstract interface class ErrorHandler {
  static late bool _printLog;
  static void configure({bool printLog = false}) => _printLog = printLog;

  static Failure handle(Object exception, StackTrace stackTrace) {
    Failure failure = switch (exception.runtimeType) {
      (Failure error) => error,
      (DioException error) => _handleDioError(error),
      _ => Failure.generic(exception.toString()),
    };
    if (_printLog) {
      debugPrint("DEBUG MESSAGE: ${failure.debugMessage}");
      debugPrint(stackTrace.toString());
    }

    return failure;
  }

  static _handleDioError(DioException error) {
    final context = navigatorKey.currentContext;

    if (error.type == DioExceptionType.connectionError) {
      return Failure.noInternet("No internet");
    }

    if (error.response?.data is! Map<String, dynamic>) {
      return Failure.generic(error.toString());
    }

    if (context != null &&
        error.response?.statusCode != null &&
        error.response?.data != null) {
      final localization = FailureLocalizations.of(context)!;
      try {
        final statusCode = error.response!.statusCode!;
        final message = localization.tr(error.response!.data["code"]);
        final debugMessage = error.response!.data["message"];

        return Failure(
          statusCode: statusCode,
          message: message,
          debugMessage: debugMessage,
        );
      } catch (_) {}
    }
    return Failure.generic(error.toString());
  }
}
