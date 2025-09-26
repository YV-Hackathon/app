// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$networkServiceHash() => r'4c8b2e586caf43cd1e43e13380de8dfa117513bd';

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
String _$storageServiceHash() => r'a79b603608e19c39370d8877a4063a05532fceb2';

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
