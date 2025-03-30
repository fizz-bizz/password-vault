import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vault/Utils/vault_card.dart';

class HiveEncryptionService {
  static const _secureStorage = FlutterSecureStorage();
  static const _encryptionKeyName = 'hive_encryption_key';
  static const _vaultBoxName = 'vaultBox';

  static Future<void> init() async {
    await _initEncryption();
  }

  static Future<Box<VaultCard>> getVaultBox() async {
    return await Hive.openBox<VaultCard>(_vaultBoxName);
  }

  static Future<void> _initEncryption() async {
    final encryptionKey = await _getEncryptionKey();
    await Hive.initFlutter();
    Hive.registerAdapter(VaultCardAdapter());
    // Decode the base64 key to bytes
    final keyBytes = base64Url.decode(encryptionKey);

    final encryptionCipher = HiveAesCipher(keyBytes); // Use decoded bytes

    await Hive.openBox<VaultCard>(
      _vaultBoxName,
      encryptionCipher: encryptionCipher,
    );
  }

  static Future<String> _getEncryptionKey() async {
    var key = await _secureStorage.read(key: _encryptionKeyName);
    if (key == null) {
      final newKey = Hive.generateSecureKey(); // 32 bytes
      key = base64Url.encode(newKey); // Store as base64
      await _secureStorage.write(key: _encryptionKeyName, value: key);
    }
    return key;
  }
}
