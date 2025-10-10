import '../../../../core/api/api_client.dart';
import '../../../../core/error/exceptions.dart';
import '../models/church_model.dart';

abstract class ChurchRemoteDataSource {
  Future<ChurchModel> getChurch(int churchId);
}

class ChurchRemoteDataSourceImpl implements ChurchRemoteDataSource {
  final ApiClient _apiClient;

  ChurchRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ChurchModel> getChurch(int churchId) async {
    try {
      print('🌐 Fetching church details from API for church ID: $churchId...');
      final response = await _apiClient.getChurch(churchId);
      print('✅ API Response received for church: ${response.name}');
      print('📋 Church details:');
      print('  - Name: ${response.name}');
      print('  - Denomination: ${response.denomination}');
      print('  - Description: ${response.description}');
      print('  - Phone: ${response.phone}');
      print('  - Email: ${response.email}');
      print('  - Website: ${response.website}');
      print('  - Founded Year: ${response.foundedYear}');
      print('  - Membership Count: ${response.membershipCount}');
      print('  - Is Active: ${response.isActive}');
      print('  - Created At: ${response.createdAt}');

      return response;
    } catch (e, stackTrace) {
      print('❌ Error in church data source: $e');
      print('❌ Error type: ${e.runtimeType}');
      print('📍 Stack trace: $stackTrace');
      throw ServerException(message: 'Failed to fetch church details: $e');
    }
  }
}
