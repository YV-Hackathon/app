import '../../domain/entities/personalization_intro.dart';
import '../../domain/repositories/personalization_intro_repository.dart';
import '../datasources/personalization_intro_local_datasource.dart';

class PersonalizationIntroRepositoryImpl
    implements PersonalizationIntroRepository {
  final PersonalizationIntroLocalDataSource _localDataSource;

  PersonalizationIntroRepositoryImpl(this._localDataSource);

  @override
  Future<List<PersonalizationIntro>> getPersonalizationIntros() async {
    final personalizationIntroModels =
        await _localDataSource.getPersonalizationIntros();
    return personalizationIntroModels
        .map(
          (model) => PersonalizationIntro(
            id: model.id,
            title: model.title,
            description: model.description,
            videoClips: model.videoClips,
          ),
        )
        .toList();
  }
}



