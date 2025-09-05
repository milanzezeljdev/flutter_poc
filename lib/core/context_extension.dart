import 'package:flutter/material.dart';
import 'package:flutter_poc/core/localizations/app_localizations.dart';
import 'package:flutter_poc/core/localizations/failure/failure_localizations.dart';

extension ExtensionGetter on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this)!;
  FailureLocalizations get failureLocalization =>
      FailureLocalizations.of(this)!;
}
