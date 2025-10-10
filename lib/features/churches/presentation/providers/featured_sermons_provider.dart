import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/global_providers/api_providers.dart';
import '../../data/models/featured_sermons_response.dart';
import '../../data/repositories/featured_sermons_repository_impl.dart';
import '../../domain/repositories/featured_sermons_repository.dart';

part 'featured_sermons_provider.g.dart';

@Riverpod(keepAlive: true)
FeaturedSermonsRepository featuredSermonsRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return FeaturedSermonsRepositoryImpl.create(apiClient);
}

@riverpod
class FeaturedSermonsNotifier extends _$FeaturedSermonsNotifier {
  @override
  Future<List<FeaturedSermonItem>> build(int churchId) async {
    print('🔄 Building featured sermons provider for church ID: $churchId');

    final repository = ref.watch(featuredSermonsRepositoryProvider);

    try {
      final sermons = await repository.getFeaturedSermons(churchId);
      print('✅ Featured sermons loaded: ${sermons.length} items');
      return sermons;
    } catch (e, stackTrace) {
      print('❌ Error loading featured sermons: $e');
      print('📍 Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<void> refresh() async {
    print('🔄 Refreshing featured sermons...');
    ref.invalidateSelf();
  }
}
