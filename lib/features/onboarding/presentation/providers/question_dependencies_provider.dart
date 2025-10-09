import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/global_providers/api_providers.dart';
import '../../data/datasources/question_remote_datasource.dart';
import '../../data/repositories/question_repository_impl.dart';
import '../../domain/repositories/question_repository.dart';
import '../../domain/usecases/get_questions_usecase.dart';

part 'question_dependencies_provider.g.dart';

@Riverpod(keepAlive: true)
QuestionRemoteDataSource questionRemoteDataSource(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return QuestionRemoteDataSourceImpl(apiClient);
}

@Riverpod(keepAlive: true)
QuestionRepository questionRepository(Ref ref) {
  final remoteDataSource = ref.watch(questionRemoteDataSourceProvider);

  return QuestionRepositoryImpl(remoteDataSource);
}

@Riverpod(keepAlive: true)
GetQuestionsUseCase getQuestionsUseCase(Ref ref) {
  final repository = ref.watch(questionRepositoryProvider);
  return GetQuestionsUseCaseImpl(repository);
}
