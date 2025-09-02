// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_poc/core/localizations/app_localizations.dart';
import 'package:yaml/yaml.dart';

class FailureLocalizations {
  FailureLocalizations(this.locale);

  final Locale locale;
  static const _FailureLocalizationsDelegate delegate =
      _FailureLocalizationsDelegate();

  static FailureLocalizations? of(BuildContext context) {
    return Localizations.of<FailureLocalizations>(
        context, FailureLocalizations);
  }

  late Map<String, String> _sentences;
  late Map<String, String> _fallbackSentences;

  Future<bool> load() async {
    final fileName = "failure_${locale.languageCode}.json";
    final filePath = 'lib/core/localizations/failure/$fileName';

    const configFilePath = "l10n.yaml";
    String configFile = await rootBundle.loadString(configFilePath);
    final config = loadYaml(configFile);
    String templateFile = config["template-arb-file"];
    final templateLanguage = templateFile.split(".").first.split("_").last;

    final fallbackName = "failure_$templateLanguage.json";
    final fallbackPath = 'lib/core/localizations/failure/$fallbackName';

    String data = await rootBundle.loadString(filePath);
    String fallbackData = await rootBundle.loadString(fallbackPath);

    Map<String, dynamic> result = json.decode(data);

    _sentences = <String, String>{};
    result.forEach((String key, dynamic value) {
      _sentences[key] = value.toString();
    });

    Map<String, dynamic> fallback = json.decode(fallbackData);

    _fallbackSentences = <String, String>{};
    fallback.forEach((String key, dynamic value) {
      _fallbackSentences[key] = value.toString();
    });

    return true;
  }

  String tr(String key) {
    final value = _sentences[key];
    final fallback = _fallbackSentences[key];
    if (value == null && fallback == null) {
      debugPrint("Translation key $key missing from file.");
      throw Exception("Translation key $key missing from file.");
    }
    return value ?? fallback!;
  }
}

class _FailureLocalizationsDelegate
    extends LocalizationsDelegate<FailureLocalizations> {
  const _FailureLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.delegate.isSupported(locale);

  @override
  Future<FailureLocalizations> load(Locale locale) async {
    FailureLocalizations localizations = FailureLocalizations(locale);
    await localizations.load();

    return localizations;
  }

  @override
  bool shouldReload(_FailureLocalizationsDelegate old) => false;
}
