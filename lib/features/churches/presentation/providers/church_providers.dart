import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/datasources/church_remote_datasource.dart';
import '../../data/repositories/church_repository_impl.dart';
import '../../domain/repositories/church_repository.dart';
import '../../../../core/global_providers/api_providers.dart';

part 'church_providers.g.dart';

@Riverpod(keepAlive: true)
ChurchRemoteDataSource churchRemoteDataSource(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ChurchRemoteDataSourceImpl(apiClient);
}

@Riverpod(keepAlive: true)
ChurchRepository churchRepository(Ref ref) {
  final remoteDataSource = ref.watch(churchRemoteDataSourceProvider);
  return ChurchRepositoryImpl(remoteDataSource);
}
