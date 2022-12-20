import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage{

  Future<void> setValue(String? key, String? value) async {
    // Create storage
    const storage = FlutterSecureStorage();

    const options = AndroidOptions(storageCipherAlgorithm: StorageCipherAlgorithm.AES_CBC_PKCS7Padding);
    // set value
    await storage.write(key: key!, value: value, aOptions: options);
  }

  Future getValue(String? key) async {
    // Create storage
    const storage = FlutterSecureStorage();
    const options = AndroidOptions(storageCipherAlgorithm: StorageCipherAlgorithm.AES_CBC_PKCS7Padding);
    // Read value
    var value = await storage.read(key: key!,aOptions: options);
    return value;
  }

}
