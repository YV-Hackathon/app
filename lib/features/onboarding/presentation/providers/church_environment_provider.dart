import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/church_environment_state.dart';
import '../../domain/entities/church_environment.dart';

part 'church_environment_provider.g.dart';

@riverpod
class ChurchEnvironmentNotifier extends _$ChurchEnvironmentNotifier {
  @override
  ChurchEnvironmentState build() {
    // Create mock church environments directly and return them immediately
    final churchEnvironments = <ChurchEnvironment>[
      const ChurchEnvironment(
        id: '1',
        title: 'Traditional',
        description: 'Hymns, liturgy, and structured services',
      ),
      const ChurchEnvironment(
        id: '2',
        title: 'Contemporary',
        description: 'Modern worship and casual style',
      ),
      const ChurchEnvironment(
        id: '3',
        title: 'Blended',
        description: 'A mix of traditional and modern services',
      ),
    ];

    return ChurchEnvironmentState(churchEnvironments: churchEnvironments);
  }

  void selectChurchEnvironment(String churchEnvironmentId) {
    // Only one can be selected at a time
    state = state.copyWith(selectedChurchEnvironmentId: churchEnvironmentId);
  }

  bool get hasSelectedChurchEnvironment {
    return state.selectedChurchEnvironmentId != null;
  }
}



