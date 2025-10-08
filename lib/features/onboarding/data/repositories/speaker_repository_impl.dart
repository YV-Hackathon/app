import '../../domain/entities/speaker.dart';
import '../../domain/repositories/speaker_repository.dart';
import '../datasources/speaker_local_datasource.dart';

class SpeakerRepositoryImpl implements SpeakerRepository {
  final SpeakerLocalDataSource _localDataSource;

  SpeakerRepositoryImpl(this._localDataSource);

  @override
  Future<List<Speaker>> getSpeakers() async {
    final speakerModels = await _localDataSource.getSpeakers();
    return speakerModels
        .map(
          (model) => Speaker(
            id: model.id,
            name: model.name,
            imageUrl: model.imageUrl,
            isSelected: model.isSelected,
          ),
        )
        .toList();
  }
}
