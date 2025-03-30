import 'package:flutter/material.dart';
import 'package:vault/Utils/vault_card.dart';
import 'package:hive/hive.dart';
import 'package:vault/Hive/hive_encryption_service.dart';

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
