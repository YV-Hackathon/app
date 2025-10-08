import 'package:flutter_riverpod/flutter_riverpod.dart';

/// State for sermon clips page
class SermonClipsState {
  final bool hasCompletedAllCards;
  final int remainingCards;

  const SermonClipsState({
    this.hasCompletedAllCards = false,
    this.remainingCards = 5,
  });

  SermonClipsState copyWith({bool? hasCompletedAllCards, int? remainingCards}) {
    return SermonClipsState(
      hasCompletedAllCards: hasCompletedAllCards ?? this.hasCompletedAllCards,
      remainingCards: remainingCards ?? this.remainingCards,
    );
  }
}

/// Notifier for sermon clips page
class SermonClipsNotifier extends StateNotifier<SermonClipsState> {
  SermonClipsNotifier() : super(const SermonClipsState());

  void initialize(int totalCards) {
    state = SermonClipsState(
      hasCompletedAllCards: false,
      remainingCards: totalCards,
    );
  }

  void decrementRemainingCards() {
    if (state.remainingCards > 0) {
      state = state.copyWith(remainingCards: state.remainingCards - 1);
    }
  }

  void markAllCardsComplete() {
    state = state.copyWith(hasCompletedAllCards: true);
  }

  void reset() {
    state = const SermonClipsState();
  }
}

/// Provider for sermon clips state
final sermonClipsProvider =
    StateNotifierProvider<SermonClipsNotifier, SermonClipsState>((ref) {
      return SermonClipsNotifier();
    });
