// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$networkServiceHash() => r'a893221fcc2d8846ea0276044e9ef946a9e96060';

/// See also [networkService].
@ProviderFor(networkService)
final networkServiceProvider = AutoDisposeProvider<NetworkService>.internal(
  networkService,
  name: r'networkServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$networkServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NetworkServiceRef = AutoDisposeProviderRef<NetworkService>;
String _$storageServiceHash() => r'ffa833dab04a84e84a4d9c9e2b9cdc4b1729853d';

/// See also [storageService].
@ProviderFor(storageService)
final storageServiceProvider = AutoDisposeProvider<StorageService>.internal(
  storageService,
  name: r'storageServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$storageServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StorageServiceRef = AutoDisposeProviderRef<StorageService>;
String _$authNotifierHash() => r'1dfbc16c411244ee959cb9cc688bcdc0199497e7';

/// See also [AuthNotifier].
@ProviderFor(AuthNotifier)
final authNotifierProvider =
    AutoDisposeAsyncNotifierProvider<AuthNotifier, UserEntity?>.internal(
  AuthNotifier.new,
  name: r'authNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthNotifier = AutoDisposeAsyncNotifier<UserEntity?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
