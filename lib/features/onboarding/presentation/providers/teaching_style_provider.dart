import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/teaching_style_state.dart';
import '../../domain/entities/teaching_style.dart';

part 'teaching_style_provider.g.dart';

@riverpod
class TeachingStyleNotifier extends _$TeachingStyleNotifier {
  @override
  TeachingStyleState build() {
    // Create mock teaching styles directly and return them immediately
    final teachingStyles = <TeachingStyle>[
      const TeachingStyle(
        id: '1',
        title: 'Academic',
        description: 'In-depth explanations and context',
      ),
      const TeachingStyle(
        id: '2',
        title: 'Relatable',
        description: 'Everyday examples that connect to your life',
      ),
      const TeachingStyle(
        id: '3',
        title: 'Balanced',
        description: 'A balance of depth and accessibility.',
      ),
    ];

    return TeachingStyleState(teachingStyles: teachingStyles);
  }

  void selectTeachingStyle(String teachingStyleId) {
    // Only one can be selected at a time
    state = state.copyWith(selectedTeachingStyleId: teachingStyleId);
  }

  bool get hasSelectedTeachingStyle {
    return state.selectedTeachingStyleId != null;
  }
}



