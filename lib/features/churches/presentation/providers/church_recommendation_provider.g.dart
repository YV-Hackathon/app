// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'church_recommendation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$churchRecommendationRepositoryHash() =>
    r'3ca1fce0ef4d26f20340a477a076149f7bb3af00';

/// See also [churchRecommendationRepository].
@ProviderFor(churchRecommendationRepository)
final churchRecommendationRepositoryProvider =
    AutoDisposeProvider<ChurchRecommendationRepository>.internal(
  churchRecommendationRepository,
  name: r'churchRecommendationRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$churchRecommendationRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChurchRecommendationRepositoryRef
    = AutoDisposeProviderRef<ChurchRecommendationRepository>;
String _$churchRecommendationNotifierHash() =>
    r'b770070c8b711557c104793e91d39ac57d31f6f8';

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

abstract class _$ChurchRecommendationNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<Church>> {
  late final int userId;

  FutureOr<List<Church>> build(
    int userId,
  );
}

/// See also [ChurchRecommendationNotifier].
@ProviderFor(ChurchRecommendationNotifier)
const churchRecommendationNotifierProvider =
    ChurchRecommendationNotifierFamily();

/// See also [ChurchRecommendationNotifier].
class ChurchRecommendationNotifierFamily
    extends Family<AsyncValue<List<Church>>> {
  /// See also [ChurchRecommendationNotifier].
  const ChurchRecommendationNotifierFamily();

  /// See also [ChurchRecommendationNotifier].
  ChurchRecommendationNotifierProvider call(
    int userId,
  ) {
    return ChurchRecommendationNotifierProvider(
      userId,
    );
  }

  @override
  ChurchRecommendationNotifierProvider getProviderOverride(
    covariant ChurchRecommendationNotifierProvider provider,
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
  String? get name => r'churchRecommendationNotifierProvider';
}

/// See also [ChurchRecommendationNotifier].
class ChurchRecommendationNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ChurchRecommendationNotifier,
        List<Church>> {
  /// See also [ChurchRecommendationNotifier].
  ChurchRecommendationNotifierProvider(
    int userId,
  ) : this._internal(
          () => ChurchRecommendationNotifier()..userId = userId,
          from: churchRecommendationNotifierProvider,
          name: r'churchRecommendationNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$churchRecommendationNotifierHash,
          dependencies: ChurchRecommendationNotifierFamily._dependencies,
          allTransitiveDependencies:
              ChurchRecommendationNotifierFamily._allTransitiveDependencies,
          userId: userId,
        );

  ChurchRecommendationNotifierProvider._internal(
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
  FutureOr<List<Church>> runNotifierBuild(
    covariant ChurchRecommendationNotifier notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(ChurchRecommendationNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChurchRecommendationNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ChurchRecommendationNotifier,
      List<Church>> createElement() {
    return _ChurchRecommendationNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChurchRecommendationNotifierProvider &&
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
mixin ChurchRecommendationNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<Church>> {
  /// The parameter `userId` of this provider.
  int get userId;
}

class _ChurchRecommendationNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        ChurchRecommendationNotifier,
        List<Church>> with ChurchRecommendationNotifierRef {
  _ChurchRecommendationNotifierProviderElement(super.provider);

  @override
  int get userId => (origin as ChurchRecommendationNotifierProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
