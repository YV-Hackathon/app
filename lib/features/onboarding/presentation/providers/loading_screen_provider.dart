import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/loading_screen_state.dart';
import '../../domain/entities/loading_screen.dart';

part 'loading_screen_provider.g.dart';

@riverpod
class LoadingScreenNotifier extends _$LoadingScreenNotifier {
  @override
  LoadingScreenState build() {
    // Create mock loading screen directly and return it immediately
    final loadingScreens = <LoadingScreen>[
      const LoadingScreen(
        id: '1',
        title: 'Connecting you with church families',
        description: 'We\'re finding the perfect matches for you',
        buttonText: 'Continue',
        progressSteps: 4,
        currentStep: 1,
      ),
    ];

    return LoadingScreenState(loadingScreens: loadingScreens);
  }

  void startProcessing() {
    state = state.copyWith(isProcessing: true);
  }

  void stopProcessing() {
    state = state.copyWith(isProcessing: false);
  }
}



