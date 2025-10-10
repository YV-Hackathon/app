// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'church_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$churchDetailNotifierHash() =>
    r'da7c6e30a60d6cd478e022f5158156aaef98c724';

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

abstract class _$ChurchDetailNotifier
    extends BuildlessAutoDisposeAsyncNotifier<ChurchDetail?> {
  late final int churchId;

  FutureOr<ChurchDetail?> build(
    int churchId,
  );
}

/// See also [ChurchDetailNotifier].
@ProviderFor(ChurchDetailNotifier)
const churchDetailNotifierProvider = ChurchDetailNotifierFamily();

/// See also [ChurchDetailNotifier].
class ChurchDetailNotifierFamily extends Family<AsyncValue<ChurchDetail?>> {
  /// See also [ChurchDetailNotifier].
  const ChurchDetailNotifierFamily();

  /// See also [ChurchDetailNotifier].
  ChurchDetailNotifierProvider call(
    int churchId,
  ) {
    return ChurchDetailNotifierProvider(
      churchId,
    );
  }

  @override
  ChurchDetailNotifierProvider getProviderOverride(
    covariant ChurchDetailNotifierProvider provider,
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
  String? get name => r'churchDetailNotifierProvider';
}

/// See also [ChurchDetailNotifier].
class ChurchDetailNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ChurchDetailNotifier, ChurchDetail?> {
  /// See also [ChurchDetailNotifier].
  ChurchDetailNotifierProvider(
    int churchId,
  ) : this._internal(
          () => ChurchDetailNotifier()..churchId = churchId,
          from: churchDetailNotifierProvider,
          name: r'churchDetailNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$churchDetailNotifierHash,
          dependencies: ChurchDetailNotifierFamily._dependencies,
          allTransitiveDependencies:
              ChurchDetailNotifierFamily._allTransitiveDependencies,
          churchId: churchId,
        );

  ChurchDetailNotifierProvider._internal(
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
  FutureOr<ChurchDetail?> runNotifierBuild(
    covariant ChurchDetailNotifier notifier,
  ) {
    return notifier.build(
      churchId,
    );
  }

  @override
  Override overrideWith(ChurchDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChurchDetailNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ChurchDetailNotifier, ChurchDetail?>
      createElement() {
    return _ChurchDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChurchDetailNotifierProvider && other.churchId == churchId;
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
mixin ChurchDetailNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<ChurchDetail?> {
  /// The parameter `churchId` of this provider.
  int get churchId;
}

class _ChurchDetailNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ChurchDetailNotifier,
        ChurchDetail?> with ChurchDetailNotifierRef {
  _ChurchDetailNotifierProviderElement(super.provider);

  @override
  int get churchId => (origin as ChurchDetailNotifierProvider).churchId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
