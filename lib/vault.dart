library vault;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'src/locker.dart';
import 'src/locator.dart';

Vault? _vault;

///Get [Object] stored in secure storage key [key]
///
/// Returns null if an [Object] is not found
Future<Object?> get(String key) => _getVault().get(key);

///Get a [Stream] of [Object]
///
/// Return a [Stream] of null if an object is not found
Stream<Object?> listen(String key) => _getVault().listen(key);

///Save [object] in secure storage with [key]
void save(String key, Object object) => _getVault().save(key, object);

///Deletes the value stored with [key]
void delete(String key) => _getVault().delete(key);

///Deletes everything stored in Vault
void deleteAll() => _getVault().deleteAll();

Vault get instance => _getVault();

Vault _getVault(){
  if(_vault == null){
    locator.registerLazySingleton(() => FlutterSecureStorage());
    _vault = Vault();
  }
  return _vault!;
}



