// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_submission_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$onboardingSubmissionRepositoryHash() =>
    r'653277dd1c96040d3afc33a4741758f45a34b670';

/// Repository Provider
///
/// Copied from [onboardingSubmissionRepository].
@ProviderFor(onboardingSubmissionRepository)
final onboardingSubmissionRepositoryProvider =
    Provider<OnboardingSubmissionRepository>.internal(
  onboardingSubmissionRepository,
  name: r'onboardingSubmissionRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onboardingSubmissionRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OnboardingSubmissionRepositoryRef
    = ProviderRef<OnboardingSubmissionRepository>;
String _$submitOnboardingUseCaseHash() =>
    r'56050a7c0986bf63cd838e76e58deeee369a4140';

/// Use Case Provider
///
/// Copied from [submitOnboardingUseCase].
@ProviderFor(submitOnboardingUseCase)
final submitOnboardingUseCaseProvider =
    Provider<SubmitOnboardingUseCase>.internal(
  submitOnboardingUseCase,
  name: r'submitOnboardingUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$submitOnboardingUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SubmitOnboardingUseCaseRef = ProviderRef<SubmitOnboardingUseCase>;
String _$onboardingSubmissionNotifierHash() =>
    r'44820dd6568513b95bad1253b99c6c340871b228';

/// Submission Notifier
///
/// Copied from [OnboardingSubmissionNotifier].
@ProviderFor(OnboardingSubmissionNotifier)
final onboardingSubmissionNotifierProvider = AutoDisposeNotifierProvider<
    OnboardingSubmissionNotifier, OnboardingSubmissionState>.internal(
  OnboardingSubmissionNotifier.new,
  name: r'onboardingSubmissionNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onboardingSubmissionNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OnboardingSubmissionNotifier
    = AutoDisposeNotifier<OnboardingSubmissionState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
