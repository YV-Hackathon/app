// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sermon_recommendation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sermonRecommendationRepositoryHash() =>
    r'47634916f1e29b69304337568c900111316f22b3';

/// Repository Provider
///
/// Copied from [sermonRecommendationRepository].
@ProviderFor(sermonRecommendationRepository)
final sermonRecommendationRepositoryProvider =
    Provider<SermonRecommendationRepository>.internal(
  sermonRecommendationRepository,
  name: r'sermonRecommendationRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sermonRecommendationRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SermonRecommendationRepositoryRef
    = ProviderRef<SermonRecommendationRepository>;
String _$getSermonRecommendationsUseCaseHash() =>
    r'd82b666e44a5d550b44b9deddba29cb8ec3e3677';

/// Use Case Provider
///
/// Copied from [getSermonRecommendationsUseCase].
@ProviderFor(getSermonRecommendationsUseCase)
final getSermonRecommendationsUseCaseProvider =
    Provider<GetSermonRecommendationsUseCase>.internal(
  getSermonRecommendationsUseCase,
  name: r'getSermonRecommendationsUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getSermonRecommendationsUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetSermonRecommendationsUseCaseRef
    = ProviderRef<GetSermonRecommendationsUseCase>;
String _$sermonRecommendationNotifierHash() =>
    r'2211d0a39a15452c9d0a1f53beee057a1721a1a7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$SermonRecommendationNotifier
    extends BuildlessAutoDisposeAsyncNotifier<SermonRecommendationResponse> {
  late final int userId;

  FutureOr<SermonRecommendationResponse> build(
    int userId,
  );
}

/// Recommendations State Provider
///
/// Copied from [SermonRecommendationNotifier].
@ProviderFor(SermonRecommendationNotifier)
const sermonRecommendationNotifierProvider =
    SermonRecommendationNotifierFamily();

/// Recommendations State Provider
///
/// Copied from [SermonRecommendationNotifier].
class SermonRecommendationNotifierFamily
    extends Family<AsyncValue<SermonRecommendationResponse>> {
  /// Recommendations State Provider
  ///
  /// Copied from [SermonRecommendationNotifier].
  const SermonRecommendationNotifierFamily();

  /// Recommendations State Provider
  ///
  /// Copied from [SermonRecommendationNotifier].
  SermonRecommendationNotifierProvider call(
    int userId,
  ) {
    return SermonRecommendationNotifierProvider(
      userId,
    );
  }

  @override
  SermonRecommendationNotifierProvider getProviderOverride(
    covariant SermonRecommendationNotifierProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'sermonRecommendationNotifierProvider';
}

/// Recommendations State Provider
///
/// Copied from [SermonRecommendationNotifier].
class SermonRecommendationNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SermonRecommendationNotifier,
        SermonRecommendationResponse> {
  /// Recommendations State Provider
  ///
  /// Copied from [SermonRecommendationNotifier].
  SermonRecommendationNotifierProvider(
    int userId,
  ) : this._internal(
          () => SermonRecommendationNotifier()..userId = userId,
          from: sermonRecommendationNotifierProvider,
          name: r'sermonRecommendationNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sermonRecommendationNotifierHash,
          dependencies: SermonRecommendationNotifierFamily._dependencies,
          allTransitiveDependencies:
              SermonRecommendationNotifierFamily._allTransitiveDependencies,
          userId: userId,
        );

  SermonRecommendationNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final int userId;

  @override
  FutureOr<SermonRecommendationResponse> runNotifierBuild(
    covariant SermonRecommendationNotifier notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(SermonRecommendationNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: SermonRecommendationNotifierProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SermonRecommendationNotifier,
      SermonRecommendationResponse> createElement() {
    return _SermonRecommendationNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SermonRecommendationNotifierProvider &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SermonRecommendationNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<SermonRecommendationResponse> {
  /// The parameter `userId` of this provider.
  int get userId;
}

class _SermonRecommendationNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        SermonRecommendationNotifier,
        SermonRecommendationResponse> with SermonRecommendationNotifierRef {
  _SermonRecommendationNotifierProviderElement(super.provider);

  @override
  int get userId => (origin as SermonRecommendationNotifierProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
