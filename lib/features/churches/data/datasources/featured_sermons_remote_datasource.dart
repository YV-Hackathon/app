import '../../../../core/api/api_client.dart';
import '../../../../core/error/exceptions.dart';
import '../models/featured_sermons_response.dart';

abstract class FeaturedSermonsRemoteDataSource {
  Future<List<FeaturedSermonItem>> getFeaturedSermons(int churchId);
}

class FeaturedSermonsRemoteDataSourceImpl
    implements FeaturedSermonsRemoteDataSource {
  final ApiClient _apiClient;

  FeaturedSermonsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<FeaturedSermonItem>> getFeaturedSermons(int churchId) async {
    try {
      print('🌐 Fetching featured sermons for church ID: $churchId...');
      final response = await _apiClient.getFeaturedSermons(churchId);
      print(
        '✅ Featured sermons API Response received: ${response.length} sermons',
      );
      return response;
    } catch (e, stackTrace) {
      print('❌ Error in featured sermons data source: $e');
      print('❌ Error type: ${e.runtimeType}');
      print('📍 Stack trace: $stackTrace');
      throw ServerException(message: 'Failed to fetch featured sermons: $e');
    }
  }
}
