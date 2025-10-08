import '../entities/teaching_style.dart';

abstract class TeachingStyleRepository {
  Future<List<TeachingStyle>> getTeachingStyles();
}



