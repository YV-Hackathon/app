import '../../data/models/featured_sermons_response.dart';

abstract class FeaturedSermonsRepository {
  Future<List<FeaturedSermonItem>> getFeaturedSermons(int churchId);
}
