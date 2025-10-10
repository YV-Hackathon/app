import '../entities/church_detail.dart';

abstract class ChurchRepository {
  Future<ChurchDetail> getChurch(int churchId);
}
