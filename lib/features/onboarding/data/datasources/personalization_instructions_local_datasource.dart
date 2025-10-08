import '../models/personalization_instructions_model.dart';

abstract class PersonalizationInstructionsLocalDataSource {
  Future<List<PersonalizationInstructionsModel>>
  getPersonalizationInstructions();
}

class PersonalizationInstructionsLocalDataSourceImpl
    implements PersonalizationInstructionsLocalDataSource {
  @override
  Future<List<PersonalizationInstructionsModel>>
  getPersonalizationInstructions() async {
    return [
      const PersonalizationInstructionsModel(
        id: '1',
        title: 'Swipe right if a message speaks to you',
        description: 'Discover pastors that resonate with you',
        videoClips: [
          'assets/videos/pastor_clip_1.mp4',
          'assets/videos/pastor_clip_2.mp4',
          'assets/videos/pastor_clip_3.mp4',
        ],
        showLikeButton: true,
      ),
    ];
  }
}



