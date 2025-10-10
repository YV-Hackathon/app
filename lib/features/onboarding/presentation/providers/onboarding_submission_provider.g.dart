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
String _$recommendedSermonsHash() =>
    r'b9ee225dab3d31a704386f31be260539d3d7119a';

/// Provider to access recommended sermons from the submission response
///
/// Copied from [recommendedSermons].
@ProviderFor(recommendedSermons)
final recommendedSermonsProvider = Provider<List<RecommendedSermon>>.internal(
  recommendedSermons,
  name: r'recommendedSermonsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recommendedSermonsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RecommendedSermonsRef = ProviderRef<List<RecommendedSermon>>;
String _$hasRecommendedSermonsHash() =>
    r'603c0dec5ee219a1a692da41a22877f76838f006';

/// Provider to check if recommended sermons are available
///
/// Copied from [hasRecommendedSermons].
@ProviderFor(hasRecommendedSermons)
final hasRecommendedSermonsProvider = Provider<bool>.internal(
  hasRecommendedSermons,
  name: r'hasRecommendedSermonsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasRecommendedSermonsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HasRecommendedSermonsRef = ProviderRef<bool>;
String _$onboardingSubmissionNotifierHash() =>
    r'ee003c831c1dc0badeacd269b1a16f66266bf900';

/// Submission Notifier
///
/// Copied from [OnboardingSubmissionNotifier].
@ProviderFor(OnboardingSubmissionNotifier)
final onboardingSubmissionNotifierProvider = NotifierProvider<
    OnboardingSubmissionNotifier, OnboardingSubmissionState>.internal(
  OnboardingSubmissionNotifier.new,
  name: r'onboardingSubmissionNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onboardingSubmissionNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OnboardingSubmissionNotifier = Notifier<OnboardingSubmissionState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
