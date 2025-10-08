import '../../domain/entities/loading_screen.dart';
import '../../domain/repositories/loading_screen_repository.dart';
import '../datasources/loading_screen_local_datasource.dart';

class LoadingScreenRepositoryImpl implements LoadingScreenRepository {
  final LoadingScreenLocalDataSource _localDataSource;

  LoadingScreenRepositoryImpl(this._localDataSource);

  @override
  Future<List<LoadingScreen>> getLoadingScreens() async {
    final loadingScreenModels = await _localDataSource.getLoadingScreens();
    return loadingScreenModels
        .map(
          (model) => LoadingScreen(
            id: model.id,
            title: model.title,
            description: model.description,
            buttonText: model.buttonText,
            progressSteps: model.progressSteps,
            currentStep: model.currentStep,
          ),
        )
        .toList();
  }
}



