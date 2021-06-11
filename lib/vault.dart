library vault;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'src/locker.dart';
import 'src/locator.dart';

Vault? _vault;

Future<Object?> get(String key) => getVault().get(key);

Stream<Object?> listen(String key) => getVault().listen(key);

void save(String key, Object object) => getVault().save(key, object);

void delete(String key) => getVault().delete(key);

void deleteAll() => getVault().deleteAll();

Vault getVault(){
  if(_vault == null){
    locator.registerLazySingleton(() => FlutterSecureStorage());
    _vault = Vault();
  }
  return _vault!;
}



