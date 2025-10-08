import '../entities/personalization_intro.dart';

abstract class PersonalizationIntroRepository {
  Future<List<PersonalizationIntro>> getPersonalizationIntros();
}



