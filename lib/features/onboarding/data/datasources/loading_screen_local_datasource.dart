import '../models/loading_screen_model.dart';

abstract class LoadingScreenLocalDataSource {
  Future<List<LoadingScreenModel>> getLoadingScreens();
}

class LoadingScreenLocalDataSourceImpl implements LoadingScreenLocalDataSource {
  @override
  Future<List<LoadingScreenModel>> getLoadingScreens() async {
    return [
      const LoadingScreenModel(
        id: '1',
        title: 'Connecting you with church families',
        description: 'We\'re finding the perfect matches for you',
        buttonText: 'Continue',
        progressSteps: 4,
        currentStep: 1,
      ),
    ];
  }
}



