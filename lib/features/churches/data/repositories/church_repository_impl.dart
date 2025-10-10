import '../../domain/entities/church_detail.dart';
import '../../domain/repositories/church_repository.dart';
import '../datasources/church_remote_datasource.dart';
import '../models/church_model.dart';

class ChurchRepositoryImpl implements ChurchRepository {
  final ChurchRemoteDataSource _remoteDataSource;

  ChurchRepositoryImpl(this._remoteDataSource);

  @override
  Future<ChurchDetail> getChurch(int churchId) async {
    print(
      '🏦 Repository: Starting to fetch church details for ID: $churchId...',
    );
    try {
      final churchModel = await _remoteDataSource.getChurch(churchId);
      print('🏦 Repository: Received church model: ${churchModel.name}');

      final churchDetail = churchModel.toEntity();

      print('🏦 Repository: Converted to entity: ${churchDetail.name}');
      print('🏦 Repository: Returning church detail');

      return churchDetail;
    } catch (e, stackTrace) {
      print('❌ Error in church repository: $e');
      print('📍 Stack trace: $stackTrace');
      rethrow;
    }
  }
}
