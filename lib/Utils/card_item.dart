import 'package:flutter/material.dart';
import 'package:vault/Utils/UI_utils/gradient_borders.dart';
import 'package:vault/Utils/vault_card.dart';

class CardItem extends StatelessWidget {
  final VaultCard card;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const CardItem({
    super.key,
    required this.card,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: GradientOutlineBorder(
        gradient: card.isMultiCard
            ? const LinearGradient(colors: [
                Colors.black,
                Colors.purpleAccent,
              ])
            : const LinearGradient(colors: [
                Colors.lightBlue,
                Colors.black,
              ]),
        width: 2,
        borderRadius: 12,
      ),
      elevation: 4,
      child: ListTile(
        title: Text(card.account),
        subtitle: !card.isMultiCard ? Text('••••••••') : null,
        trailing: card.isMultiCard ? const Icon(Icons.arrow_forward_ios) : null,
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}
