import 'package:dio/dio.dart';
import 'package:flutter_poc/core/env.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio.g.dart';

@riverpod
Dio dio(Ref ref) {
  final baseUrl = Env.get(EnvKey.url);
  final dio = Dio(BaseOptions(baseUrl: baseUrl));

  return dio;
}
