import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_poc/core/env.dart';
import 'package:flutter_poc/core/error_handler.dart';
import 'package:flutter_poc/core/localizations/app_localizations.dart';
import 'package:flutter_poc/core/localizations/failure/failure_localizations.dart';
import 'package:flutter_poc/presentation/screens/home_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  await Env.load(fileName: "lib/.env");
  ErrorHandler.configure(printLog: true);

  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: HomeScreen(),
      ),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: [
        FailureLocalizations.delegate,
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
