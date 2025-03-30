import 'package:flutter/material.dart';
import 'package:vault/Utils/vault_card.dart';

void showCardDetails(BuildContext context, VaultCard card) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(card.account),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Password: '),
          SelectableText(card.password ?? ''),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        )
      ],
    ),
  );
}
