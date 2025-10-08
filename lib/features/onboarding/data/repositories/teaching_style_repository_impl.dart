import '../../domain/entities/teaching_style.dart';
import '../../domain/repositories/teaching_style_repository.dart';
import '../datasources/teaching_style_local_datasource.dart';

class TeachingStyleRepositoryImpl implements TeachingStyleRepository {
  final TeachingStyleLocalDataSource _localDataSource;

  TeachingStyleRepositoryImpl(this._localDataSource);

  @override
  Future<List<TeachingStyle>> getTeachingStyles() async {
    final teachingStyleModels = await _localDataSource.getTeachingStyles();
    return teachingStyleModels.map((model) => TeachingStyle(
      id: model.id,
      title: model.title,
      description: model.description,
      isSelected: model.isSelected,
    )).toList();
  }
}



