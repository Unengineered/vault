import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'locator.dart';

abstract class Locker{
  ///Save [object] in secure storage with [key
  void save(String key,Object object);

  ///Get [Object] stored in secure storage key [key]
  ///
  /// Returns null if an [Object] is not found
  Future<Object?> get(String key);

  ///Get a [Stream] of [Object]
  ///
  /// Return a [Stream] of null if an object is not found
  Stream<Object?> listen(String key);

  ///Deletes the value stored with [key]
  void delete(String key);

  ///Deletes everything stored in [Vault]
  void deleteAll();
}

class Vault implements Locker{
  final storage = locator<FlutterSecureStorage>();
  Map<String, StreamController> streams = Map();

  @override
  void delete(String key) => storage.delete(key: key);

  @override
  void deleteAll() => storage.deleteAll();

  @override
  Future<Object?> get(String key) async {
    final string = await storage.read(key: key);
    if(string == null) return Future.value();

    final json = jsonDecode(string);

    switch(json['type']){
      case 'int': return int.parse(json['data']);
      case 'double': return double.parse(json['data']);
      case 'bool': return json['data'].toLowerCase() == 'true';
      case 'String': return json['data'].toString();
    }
  }

  @override
  Stream<Object?> listen(String key) {
    if(streams[key] == null){
      streams[key] = StreamController();
    }

    return streams[key]!.stream;
  }

  @override
  void save(String key, Object object) {
    final map = Map<String, String>();
    map['type'] = object.runtimeType.toString();
    map['data'] = object.toString();

    storage.write(key: key, value: jsonEncode(map));

    if(streams[key] != null && streams[key]!.hasListener) streams[key]!.add(object);
  }
}