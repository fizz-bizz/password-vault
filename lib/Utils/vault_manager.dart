// import 'dart:math';
// import 'dart:typed_data';
// import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:vault/Utils/vault_card.dart';
import 'package:hive/hive.dart';
import 'package:vault/Hive/hive_encryption_service.dart';
import 'dart:convert';
import 'dart:io';

class VaultManager extends ChangeNotifier {
  Box<VaultCard>? _vaultBox;

  Future<void> initialize() async {
    _vaultBox = await HiveEncryptionService.getVaultBox();
    notifyListeners();
  }

  List<VaultCard> get mainCards => _vaultBox?.values.toList() ?? [];

  void addCard(VaultCard card, [String? parentId]) {
    final box = _vaultBox;

    if (parentId == null) {
      box?.add(card);
    } else {
      final parent = _findParentCard(parentId);
      if (parent != null) {
        parent.subCards.add(card);
        parent.save();
      }
    }
    notifyListeners();
  }

  Future<void> exportBackup(String path) async {
    final data = _vaultBox!.values.map((card) => card.toJson()).toList();

    final file = File('$path/vault_backup.json');
    await file.writeAsString(jsonEncode(data));
  }

  Future<void> importBackup(String filePath) async {
    final file = File(filePath);
    final data = jsonDecode(await file.readAsString()) as List;
    for (var item in data) {
      addCard(VaultCard.fromJson(item));
      notifyListeners();
    }
  }

  VaultCard? _findParentCard(String parentId) {
    try {
      return _vaultBox?.values.firstWhere(
        (card) => card.id == parentId,
      );
    } catch (_) {
      return null;
    }
  }

  void updateCard(VaultCard card) {
    card.save();
    notifyListeners();
  }
}
