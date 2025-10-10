// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_sermons_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$featuredSermonsRepositoryHash() =>
    r'94670ee0709dfc40c75a25e122ce2298c20eed76';

/// See also [featuredSermonsRepository].
@ProviderFor(featuredSermonsRepository)
final featuredSermonsRepositoryProvider =
    Provider<FeaturedSermonsRepository>.internal(
  featuredSermonsRepository,
  name: r'featuredSermonsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$featuredSermonsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FeaturedSermonsRepositoryRef = ProviderRef<FeaturedSermonsRepository>;
String _$featuredSermonsNotifierHash() =>
    r'77420dee3d81c20287859141446e5f8f8e00c798';

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

abstract class _$FeaturedSermonsNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<FeaturedSermonItem>> {
  late final int churchId;

  FutureOr<List<FeaturedSermonItem>> build(
    int churchId,
  );
}

/// See also [FeaturedSermonsNotifier].
@ProviderFor(FeaturedSermonsNotifier)
const featuredSermonsNotifierProvider = FeaturedSermonsNotifierFamily();

/// See also [FeaturedSermonsNotifier].
class FeaturedSermonsNotifierFamily
    extends Family<AsyncValue<List<FeaturedSermonItem>>> {
  /// See also [FeaturedSermonsNotifier].
  const FeaturedSermonsNotifierFamily();

  /// See also [FeaturedSermonsNotifier].
  FeaturedSermonsNotifierProvider call(
    int churchId,
  ) {
    return FeaturedSermonsNotifierProvider(
      churchId,
    );
  }

  @override
  FeaturedSermonsNotifierProvider getProviderOverride(
    covariant FeaturedSermonsNotifierProvider provider,
  ) {
    return call(
      provider.churchId,
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
  String? get name => r'featuredSermonsNotifierProvider';
}

/// See also [FeaturedSermonsNotifier].
class FeaturedSermonsNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<FeaturedSermonsNotifier,
        List<FeaturedSermonItem>> {
  /// See also [FeaturedSermonsNotifier].
  FeaturedSermonsNotifierProvider(
    int churchId,
  ) : this._internal(
          () => FeaturedSermonsNotifier()..churchId = churchId,
          from: featuredSermonsNotifierProvider,
          name: r'featuredSermonsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$featuredSermonsNotifierHash,
          dependencies: FeaturedSermonsNotifierFamily._dependencies,
          allTransitiveDependencies:
              FeaturedSermonsNotifierFamily._allTransitiveDependencies,
          churchId: churchId,
        );

  FeaturedSermonsNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.churchId,
  }) : super.internal();

  final int churchId;

  @override
  FutureOr<List<FeaturedSermonItem>> runNotifierBuild(
    covariant FeaturedSermonsNotifier notifier,
  ) {
    return notifier.build(
      churchId,
    );
  }

  @override
  Override overrideWith(FeaturedSermonsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: FeaturedSermonsNotifierProvider._internal(
        () => create()..churchId = churchId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        churchId: churchId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<FeaturedSermonsNotifier,
      List<FeaturedSermonItem>> createElement() {
    return _FeaturedSermonsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FeaturedSermonsNotifierProvider &&
        other.churchId == churchId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, churchId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FeaturedSermonsNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<FeaturedSermonItem>> {
  /// The parameter `churchId` of this provider.
  int get churchId;
}

class _FeaturedSermonsNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<FeaturedSermonsNotifier,
        List<FeaturedSermonItem>> with FeaturedSermonsNotifierRef {
  _FeaturedSermonsNotifierProviderElement(super.provider);

  @override
  int get churchId => (origin as FeaturedSermonsNotifierProvider).churchId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
