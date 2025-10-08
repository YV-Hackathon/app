import 'package:freezed_annotation/freezed_annotation.dart';
import 'loading_screen.dart';

part 'loading_screen_state.freezed.dart';

@freezed
class LoadingScreenState with _$LoadingScreenState {
  const factory LoadingScreenState({
    @Default([]) List<LoadingScreen> loadingScreens,
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    String? error,
  }) = _LoadingScreenState;
}



