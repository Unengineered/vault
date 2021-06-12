# Vault

A library that stores int, double, String and bool in encrypted storage. Vault stores it's contents in persistent storage.

## Usage

Import package as ```vault```.
```dart
import 'package:vault/vault.dart' as vault;
```

### Save
You can save a ```value``` in secure storage by passing a ```key```.

```dart
vault.save(key, value);
```

### Get
You can get a ```value``` from secure storage by passing their ```key```.

```dart
vault.get(key);
```

### Listen
You can listen to live changes done to a ```value``` by passing their ```key```.

```dart
vault.listen(key);
```

### Delete
You can delete a ```value``` by passing their ```key```.

```dart
vault.delete(key);
```

### Delete All
Deletes all the values stored in ```vault```.

```dart
vault.listen(key);
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://github.com/Unengineered/vault/blob/main/LICENSE)