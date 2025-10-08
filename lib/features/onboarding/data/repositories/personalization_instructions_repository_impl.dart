import '../../domain/entities/personalization_instructions.dart';
import '../../domain/repositories/personalization_instructions_repository.dart';
import '../datasources/personalization_instructions_local_datasource.dart';

class PersonalizationInstructionsRepositoryImpl
    implements PersonalizationInstructionsRepository {
  final PersonalizationInstructionsLocalDataSource _localDataSource;

  PersonalizationInstructionsRepositoryImpl(this._localDataSource);

  @override
  Future<List<PersonalizationInstructions>>
  getPersonalizationInstructions() async {
    final personalizationInstructionsModels =
        await _localDataSource.getPersonalizationInstructions();
    return personalizationInstructionsModels
        .map(
          (model) => PersonalizationInstructions(
            id: model.id,
            title: model.title,
            description: model.description,
            videoClips: model.videoClips,
            showLikeButton: model.showLikeButton,
          ),
        )
        .toList();
  }
}



