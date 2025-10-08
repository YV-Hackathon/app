import '../models/church_environment_model.dart';

abstract class ChurchEnvironmentLocalDataSource {
  Future<List<ChurchEnvironmentModel>> getChurchEnvironments();
}

class ChurchEnvironmentLocalDataSourceImpl
    implements ChurchEnvironmentLocalDataSource {
  @override
  Future<List<ChurchEnvironmentModel>> getChurchEnvironments() async {
    return [
      const ChurchEnvironmentModel(
        id: '1',
        title: 'Traditional',
        description: 'Hymns, liturgy, and structured services',
      ),
      const ChurchEnvironmentModel(
        id: '2',
        title: 'Contemporary',
        description: 'Modern worship and casual style',
      ),
      const ChurchEnvironmentModel(
        id: '3',
        title: 'Blended',
        description: 'A mix of traditional and modern services',
      ),
    ];
  }
}



