// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sermon_preference_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sermonPreferenceRepositoryHash() =>
    r'e33dc5362524bad5fa6fd8fc7e76fd88b2565ff4';

/// Repository Provider
///
/// Copied from [sermonPreferenceRepository].
@ProviderFor(sermonPreferenceRepository)
final sermonPreferenceRepositoryProvider =
    Provider<SermonPreferenceRepository>.internal(
  sermonPreferenceRepository,
  name: r'sermonPreferenceRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sermonPreferenceRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SermonPreferenceRepositoryRef = ProviderRef<SermonPreferenceRepository>;
String _$submitSermonPreferenceUseCaseHash() =>
    r'a6d4bfa693033a10c8292ad542b68f88dd362077';

/// Use Case Provider
///
/// Copied from [submitSermonPreferenceUseCase].
@ProviderFor(submitSermonPreferenceUseCase)
final submitSermonPreferenceUseCaseProvider =
    Provider<SubmitSermonPreferenceUseCase>.internal(
  submitSermonPreferenceUseCase,
  name: r'submitSermonPreferenceUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$submitSermonPreferenceUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SubmitSermonPreferenceUseCaseRef
    = ProviderRef<SubmitSermonPreferenceUseCase>;
String _$sermonPreferenceNotifierHash() =>
    r'97cddd39fad7a8dce0752eb7842fe80fcf37fd22';

/// Notifier for submitting sermon preferences
///
/// Copied from [SermonPreferenceNotifier].
@ProviderFor(SermonPreferenceNotifier)
final sermonPreferenceNotifierProvider =
    AutoDisposeNotifierProvider<SermonPreferenceNotifier, void>.internal(
  SermonPreferenceNotifier.new,
  name: r'sermonPreferenceNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sermonPreferenceNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SermonPreferenceNotifier = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
