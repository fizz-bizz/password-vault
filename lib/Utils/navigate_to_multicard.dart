import 'package:flutter/material.dart';
import 'package:vault/Pages/multicard_page.dart';
import 'package:vault/Utils/vault_card.dart';

void navigateToMultiCard(BuildContext context, VaultCard card) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MultiCardPage(parentCard: card),
    ),
  );
}
