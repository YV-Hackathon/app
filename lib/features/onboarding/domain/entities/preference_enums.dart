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

  /// Map from option label/value to enum (from API response)
  static BibleReadingPreference? fromOptionValue(String optionValue) {
    switch (optionValue) {
      case 'Life Application':
        return BibleReadingPreference.moreApplication;
      case 'More Scripture':
        return BibleReadingPreference.moreScripture;
      case 'Balanced':
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

  /// Map from option label/value to enum (from API response)
  static TeachingStylePreference? fromOptionValue(String optionValue) {
    switch (optionValue) {
      case 'Warm':
        return TeachingStylePreference.warmAndConversational;
      case 'Calm':
        return TeachingStylePreference.calmAndReflective;
      case 'Passionate':
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

  /// Map from option label/value to enum (from API response)
  static EnvironmentPreference? fromOptionValue(String optionValue) {
    switch (optionValue) {
      case 'Traditional':
        return EnvironmentPreference.traditional;
      case 'Contemporary':
        return EnvironmentPreference.contemporary;
      case 'Blended':
        return EnvironmentPreference.blended;
      default:
        return null;
    }
  }
}

/// Enum for Gender Preference
enum GenderPreference {
  male('MALE'),
  female('FEMALE'),
  either('EITHER');

  final String value;
  const GenderPreference(this.value);

  static GenderPreference fromValue(String value) {
    return GenderPreference.values.firstWhere(
      (e) => e.value == value,
      orElse: () => GenderPreference.either,
    );
  }

  /// Map from option label/value to enum (from API response)
  static GenderPreference? fromOptionValue(String optionValue) {
    switch (optionValue) {
      case 'Male':
        return GenderPreference.male;
      case 'Female':
        return GenderPreference.female;
      case 'Either':
        return GenderPreference.either;
      default:
        return null;
    }
  }
}
