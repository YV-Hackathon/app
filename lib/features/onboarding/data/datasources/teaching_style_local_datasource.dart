import '../models/teaching_style_model.dart';

abstract class TeachingStyleLocalDataSource {
  Future<List<TeachingStyleModel>> getTeachingStyles();
}

class TeachingStyleLocalDataSourceImpl implements TeachingStyleLocalDataSource {
  @override
  Future<List<TeachingStyleModel>> getTeachingStyles() async {
    return [
      const TeachingStyleModel(
        id: '1',
        title: 'Academic',
        description: 'In-depth explanations and context',
      ),
      const TeachingStyleModel(
        id: '2',
        title: 'Relatable',
        description: 'Everyday examples that connect to your life',
      ),
      const TeachingStyleModel(
        id: '3',
        title: 'Balanced',
        description: 'A balance of depth and accessibility.',
      ),
    ];
  }
}



