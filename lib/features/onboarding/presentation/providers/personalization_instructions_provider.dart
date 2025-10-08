import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/personalization_instructions_state.dart';
import '../../domain/entities/personalization_instructions.dart';

part 'personalization_instructions_provider.g.dart';

@riverpod
class PersonalizationInstructionsNotifier
    extends _$PersonalizationInstructionsNotifier {
  @override
  PersonalizationInstructionsState build() {
    // Create mock personalization instructions directly and return them immediately
    final personalizationInstructions = <PersonalizationInstructions>[
      const PersonalizationInstructions(
        id: '1',
        title: 'Swipe right if a message speaks to you',
        description: 'Discover pastors that resonate with you',
        videoClips: [
          'assets/videos/pastor_clip_1.mp4',
          'assets/videos/pastor_clip_2.mp4',
          'assets/videos/pastor_clip_3.mp4',
        ],
        showLikeButton: true,
      ),
    ];

    return PersonalizationInstructionsState(
      personalizationInstructions: personalizationInstructions,
    );
  }
}



