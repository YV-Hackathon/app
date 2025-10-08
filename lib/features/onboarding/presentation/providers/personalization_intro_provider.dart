import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/personalization_intro_state.dart';
import '../../domain/entities/personalization_intro.dart';

part 'personalization_intro_provider.g.dart';

@riverpod
class PersonalizationIntroNotifier extends _$PersonalizationIntroNotifier {
  @override
  PersonalizationIntroState build() {
    // Create mock personalization intro directly and return it immediately
    final personalizationIntros = <PersonalizationIntro>[
      const PersonalizationIntro(
        id: '1',
        title: 'Now, let\'s take a moment to explore short clips from pastors',
        description: 'Discover pastors that resonate with you',
        videoClips: [
          'assets/videos/pastor_clip_1.mp4',
          'assets/videos/pastor_clip_2.mp4',
          'assets/videos/pastor_clip_3.mp4',
        ],
      ),
    ];

    return PersonalizationIntroState(
      personalizationIntros: personalizationIntros,
    );
  }
}



