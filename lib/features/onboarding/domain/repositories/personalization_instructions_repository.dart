import '../entities/personalization_instructions.dart';

abstract class PersonalizationInstructionsRepository {
  Future<List<PersonalizationInstructions>> getPersonalizationInstructions();
}



