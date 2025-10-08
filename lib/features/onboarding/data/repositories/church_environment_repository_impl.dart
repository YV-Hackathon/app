import '../../domain/entities/church_environment.dart';
import '../../domain/repositories/church_environment_repository.dart';
import '../datasources/church_environment_local_datasource.dart';

class ChurchEnvironmentRepositoryImpl implements ChurchEnvironmentRepository {
  final ChurchEnvironmentLocalDataSource _localDataSource;

  ChurchEnvironmentRepositoryImpl(this._localDataSource);

  @override
  Future<List<ChurchEnvironment>> getChurchEnvironments() async {
    final churchEnvironmentModels =
        await _localDataSource.getChurchEnvironments();
    return churchEnvironmentModels
        .map(
          (model) => ChurchEnvironment(
            id: model.id,
            title: model.title,
            description: model.description,
            isSelected: model.isSelected,
          ),
        )
        .toList();
  }
}



