import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vault/src/locator.dart';

import 'test_data.dart';

class FlutterSecureStorageMock extends Mock implements FlutterSecureStorage{}

FlutterSecureStorage getAndRegisterFlutterSecureStorageMock({Object? data}){
  //Remaking service
  _removeRegistrationIfExists<FlutterSecureStorage>();
  var service = FlutterSecureStorageMock();

  // stubbing
  when(() => service.write(key: any(named: 'key', that: isNotNull), value: any(named: 'value'))).thenAnswer((invocation){
    return Future<void>.value();
  });

  when(() => service.read(key: any(named: 'key', that: isNotNull))).thenAnswer((invocation){
    if(data is int) return Future.value(intString(data));
    if(data is double) return Future.value(doubleString(data));
    if(data is bool) return Future.value(boolString(data));
    if(data is String) return Future.value(stringString(data));
    if(data == null) return Future.value();
    return Future.value();
  });

  when(() => service.delete(key: any(named: 'key', that: isNotNull))).thenAnswer((invocation) => Future.value());

  when(() => service.deleteAll()).thenAnswer((invocation) => Future.value());

  //Adding to locator
  locator.registerSingleton<FlutterSecureStorage>(service);
  return service;
}

void registerServices(){
  getAndRegisterFlutterSecureStorageMock();
}

void unregisterServices(){
  locator.unregister<FlutterSecureStorage>();
}

void _removeRegistrationIfExists<T extends Object>(){
  if(locator.isRegistered<T>()){
    locator.unregister<T>();
  }
}