import '../entities/church_environment.dart';

abstract class ChurchEnvironmentRepository {
  Future<List<ChurchEnvironment>> getChurchEnvironments();
}



