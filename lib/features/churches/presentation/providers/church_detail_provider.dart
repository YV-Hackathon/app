import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/church_detail.dart';
import 'church_providers.dart';

part 'church_detail_provider.g.dart';

@riverpod
class ChurchDetailNotifier extends _$ChurchDetailNotifier {
  @override
  Future<ChurchDetail?> build(int churchId) async {
    if (churchId <= 0) return null;

    try {
      final repository = ref.read(churchRepositoryProvider);
      return await repository.getChurch(churchId);
    } catch (e) {
      print('❌ Error fetching church details: $e');
      rethrow;
    }
  }

  Future<void> refresh() async {
    final churchId = state.valueOrNull?.id;
    if (churchId != null) {
      ref.invalidateSelf();
    }
  }
}
