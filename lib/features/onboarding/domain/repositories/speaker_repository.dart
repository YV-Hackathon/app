import '../entities/speaker.dart';

abstract class SpeakerRepository {
  Future<List<Speaker>> getSpeakers();
}



