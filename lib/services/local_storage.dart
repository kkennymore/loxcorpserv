import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  // Create storage
  final storage = const FlutterSecureStorage();
  /*set the data */
  set(String? key, String? value) {
    storage.write(key: key!, value: value!);
  }

  /*get the data */
  get(dynamic value, {bool? isAll = false}) {
    if (isAll!) {
      return storage.readAll();
    }
    return storage.read(key: value);
  }

  /*delete stored data */
  delete({dynamic value, bool? isAll = false}) {
    if (isAll!) {
      return storage.deleteAll();
    }
    return storage.delete(key: value);
  }

}
