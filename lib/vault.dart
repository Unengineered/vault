library vault;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'src/locker.dart';
import 'src/locator.dart';

class Vault {
  late Locker _locker;

  Vault() {
    locator.registerLazySingleton<FlutterSecureStorage>(
            () => FlutterSecureStorage());
    _locker = LockerImpl();
  }

  ///Get [Object] stored in secure storage key [key]
  ///
  /// Returns null if an [Object] is not found
  Future<Object?> get(String key) => _locker.get(key);

  ///Get a [Stream] of [Object]
  ///
  /// Return a [Stream] of null if an object is not found
  Stream<Object?> listen(String key) => _locker.listen(key);

  ///Save [object] in secure storage with [key]
  void save(String key, Object object) => _locker.save(key, object);

  ///Deletes the value stored with [key]
  void delete(String key) => _locker.delete(key);

  ///Deletes everything stored in Vault
  void deleteAll() => _locker.deleteAll();
}
