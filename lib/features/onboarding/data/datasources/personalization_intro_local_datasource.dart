import '../models/personalization_intro_model.dart';

abstract class PersonalizationIntroLocalDataSource {
  Future<List<PersonalizationIntroModel>> getPersonalizationIntros();
}

class PersonalizationIntroLocalDataSourceImpl
    implements PersonalizationIntroLocalDataSource {
  @override
  Future<List<PersonalizationIntroModel>> getPersonalizationIntros() async {
    return [
      const PersonalizationIntroModel(
        id: '1',
        title: 'Now, let\'s take a moment to explore short clips from pastors',
        description: 'Discover pastors that resonate with you',
        videoClips: [
          'assets/videos/pastor_clip_1.mp4',
          'assets/videos/pastor_clip_2.mp4',
          'assets/videos/pastor_clip_3.mp4',
        ],
      ),
    ];
  }
}



