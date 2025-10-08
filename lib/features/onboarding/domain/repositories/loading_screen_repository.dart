import '../entities/loading_screen.dart';

abstract class LoadingScreenRepository {
  Future<List<LoadingScreen>> getLoadingScreens();
}



