import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:vault/src/locker.dart';

import '../setup/test_data.dart';
import '../setup/test_helpers.dart';

void main() {
  group('Save:', () {
    var storage = getAndRegisterFlutterSecureStorageMock();
    var vault = Vault();

    test('should save int when int is passed to object', () {
      //Arrange
      int value = 5;

      //Act
      vault.save('number', value);

      //Assert
      verify(() => storage.write(key: 'number', value: intString(value)))
          .called(1);
    });

    test('should save double when double is passed to object', () {
      //Arrange
      double value = 5.2;

      //Act
      vault.save('number', value);

      //Assert
      verify(() => storage.write(key: 'number', value: doubleString(value)))
          .called(1);
    });

    test('should save string when string is passed to object', () {
      //Arrange
      String value = "Test String";

      //Act
      vault.save('string', value);

      //Assert
      verify(() => storage.write(key: 'string', value: stringString(value)))
          .called(1);
    });

    test('should save bool when bool is passed to object', () {
      //Arrange
      bool value = true;

      //Act
      vault.save('bool', value);

      //Assert
      verify(() => storage.write(key: 'bool', value: boolString(value)))
          .called(1);
    });
  });
  
  group('Get:', (){
    test('should get int when int was saved', () async {
      //Arrange
      final storage = getAndRegisterFlutterSecureStorageMock(data: 5);
      final vault = Vault();

      //Act
      final number = await vault.get('key');

      //Assert
      verify(() => storage.read(key: 'key'));
      assert(number.runtimeType == int);
      expect(number, 5);
    });

    test('should get double when double was saved', () async{
      //Arrange
      final storage = getAndRegisterFlutterSecureStorageMock(data: 5.32);
      final vault = Vault();

      //Act
      final number = await vault.get('key');

      //Assert
      verify(() => storage.read(key: 'key'));
      assert(number.runtimeType == double);
      expect(number, 5.32);
    });

    test('should get bool when bool was saved', () async{
      //Arrange
      final storage = getAndRegisterFlutterSecureStorageMock(data: false);
      final vault = Vault();

      //Act
      final boolean = await vault.get('key');

      //Assert
      verify(() => storage.read(key: 'key'));
      assert(boolean.runtimeType == bool);
      expect(boolean, false);
    });

    test('should get string when string was saved', () async{
      //Arrange
      final storage = getAndRegisterFlutterSecureStorageMock(data: "Test string");
      final vault = Vault();

      //Act
      final string = await vault.get('key');

      //Assert
      verify(() => storage.read(key: 'key'));
      assert(string.runtimeType == String);
      expect(string, "Test string");
    });

    test('should get null when nothing was saved', ()async{
      //Arrange
      final storage = getAndRegisterFlutterSecureStorageMock();
      final vault = Vault();

      //Act
      final value = await vault.get('key');

      //Assert
      verify(() => storage.read(key: 'key'));
      expect(value, null);
    });
  });

  group('Delete', (){
    var storage = getAndRegisterFlutterSecureStorageMock();
    var vault = Vault();

    test('should call delete with key', (){
      //Act
      vault.delete('key');

      //Assert
      verify(() => storage.delete(key: 'key'));
    });

    test('should call delete all', (){
      //Act
      vault.deleteAll();

      //Assert
      verify(() => storage.deleteAll());
    });
  });

  group('Stream', (){
    var storage = getAndRegisterFlutterSecureStorageMock();
    var vault = Vault();

    test('stream should emit new value of key if the value is changed', (){
      //Arrange
      final stream = vault.listen('key');
      vault.save('key', 5);
      verify(() => storage.write(key: 'key', value: intString(5)));

      //Assert
      flutter_test.expectLater(stream, emitsInOrder([10]));

      //Act
      vault.save('key',10);
      verify(() => storage.write(key: 'key', value: intString(10)));
    });

  });
}
