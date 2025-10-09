/// Enum for Bible Reading Preference
enum BibleReadingPreference {
  moreScripture('MORE_SCRIPTURE'),
  moreApplication('MORE_APPLICATION'),
  balanced('BALANCED');

  final String value;
  const BibleReadingPreference(this.value);

  static BibleReadingPreference fromValue(String value) {
    return BibleReadingPreference.values.firstWhere(
      (e) => e.value == value,
      orElse: () => BibleReadingPreference.balanced,
    );
  }

  /// Map from option label/value to enum
  static BibleReadingPreference? fromOptionValue(String optionValue) {
    final normalized = optionValue.toUpperCase().replaceAll(' ', '_');
    switch (normalized) {
      case 'MORE_SCRIPTURE':
      case 'MORE SCRIPTURE':
        return BibleReadingPreference.moreScripture;
      case 'MORE_APPLICATION':
      case 'LIFE_APPLICATION':
      case 'LIFE APPLICATION':
        return BibleReadingPreference.moreApplication;
      case 'BALANCED':
        return BibleReadingPreference.balanced;
      default:
        return null;
    }
  }
}

/// Enum for Teaching Style Preference
enum TeachingStylePreference {
  warmAndConversational('WARM_AND_CONVERSATIONAL'),
  calmAndReflective('CALM_AND_REFLECTIVE'),
  passionateAndHighEnergy('PASSIONATE_AND_HIGH_ENERGY');

  final String value;
  const TeachingStylePreference(this.value);

  static TeachingStylePreference fromValue(String value) {
    return TeachingStylePreference.values.firstWhere(
      (e) => e.value == value,
      orElse: () => TeachingStylePreference.warmAndConversational,
    );
  }

  /// Map from option label/value to enum
  static TeachingStylePreference? fromOptionValue(String optionValue) {
    final normalized = optionValue.toUpperCase().replaceAll(' ', '_');
    switch (normalized) {
      // Backend enum values
      case 'WARM_AND_CONVERSATIONAL':
      case 'WARM':
      case 'CONVERSATIONAL':
      // API option labels
      case 'RELATABLE':
        return TeachingStylePreference.warmAndConversational;

      // Backend enum values
      case 'CALM_AND_REFLECTIVE':
      case 'CALM':
      case 'REFLECTIVE':
      // API option labels
      case 'ACADEMIC':
        return TeachingStylePreference.calmAndReflective;

      // Backend enum values
      case 'PASSIONATE_AND_HIGH_ENERGY':
      case 'PASSIONATE':
      case 'HIGH_ENERGY':
      // API option labels
      case 'BALANCED':
        return TeachingStylePreference.passionateAndHighEnergy;

      default:
        return null;
    }
  }
}

/// Enum for Church Environment Preference
enum EnvironmentPreference {
  traditional('TRADITIONAL'),
  contemporary('CONTEMPORARY'),
  blended('BLENDED');

  final String value;
  const EnvironmentPreference(this.value);

  static EnvironmentPreference fromValue(String value) {
    return EnvironmentPreference.values.firstWhere(
      (e) => e.value == value,
      orElse: () => EnvironmentPreference.blended,
    );
  }

  /// Map from option label/value to enum
  static EnvironmentPreference? fromOptionValue(String optionValue) {
    final normalized = optionValue.toUpperCase().replaceAll(' ', '_');
    switch (normalized) {
      case 'TRADITIONAL':
        return EnvironmentPreference.traditional;
      case 'CONTEMPORARY':
        return EnvironmentPreference.contemporary;
      case 'BLENDED':
        return EnvironmentPreference.blended;
      default:
        return null;
    }
  }
}
