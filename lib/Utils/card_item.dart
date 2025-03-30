import 'package:flutter/material.dart';
import 'package:vault/Utils/vault_card.dart';

class CardItem extends StatelessWidget {
  final VaultCard card;
  final VoidCallback onTap;

  const CardItem({super.key, required this.card, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(card.account),
        subtitle: !card.isMultiCard ? Text('••••••••') : null,
        trailing: card.isMultiCard ? const Icon(Icons.arrow_forward_ios) : null,
        onTap: onTap,
      ),
    );
  }
}
