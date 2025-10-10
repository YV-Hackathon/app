import '../../../../core/api/api_client.dart';
import '../../domain/repositories/featured_sermons_repository.dart';
import '../datasources/featured_sermons_remote_datasource.dart';
import '../models/featured_sermons_response.dart';

class FeaturedSermonsRepositoryImpl implements FeaturedSermonsRepository {
  final FeaturedSermonsRemoteDataSource _remoteDataSource;

  FeaturedSermonsRepositoryImpl(this._remoteDataSource);

  factory FeaturedSermonsRepositoryImpl.create(ApiClient apiClient) {
    return FeaturedSermonsRepositoryImpl(
      FeaturedSermonsRemoteDataSourceImpl(apiClient),
    );
  }

  @override
  Future<List<FeaturedSermonItem>> getFeaturedSermons(int churchId) async {
    try {
      print('📤 Getting featured sermons for church ID: $churchId...');

      final response = await _remoteDataSource.getFeaturedSermons(churchId);

      print('✅ Featured sermons repository successful!');
      print('📦 Response count: ${response.length}');

      return response;
    } catch (e, stackTrace) {
      print('❌ Error in featured sermons repository: $e');
      print('📍 Stack trace: $stackTrace');
      rethrow;
    }
  }
}
