import 'package:flutter_poc/domain/models/utils/failure_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'provider_state.freezed.dart';

@freezed
sealed class ProviderState<T> with _$ProviderState<T> {
  const ProviderState._();
  factory ProviderState.initial() = InitialProviderState;
  factory ProviderState.loading() = LoadingProviderState;
  factory ProviderState.empty() = EmptyProviderState;
  factory ProviderState.success(T data) = SuccessProviderState;
  factory ProviderState.error(Failure error) = ErrorProviderState;
}
