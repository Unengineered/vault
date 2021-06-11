import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setUpDependencies(){
  locator.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());
}