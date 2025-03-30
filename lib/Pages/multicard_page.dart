import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vault/Utils/card_creator_dialog.dart';
import 'package:vault/Utils/card_item.dart';
import 'package:vault/Utils/navigate_to_multicard.dart';
import 'package:vault/Utils/show_card_details.dart';
import 'package:vault/Utils/vault_card.dart';
import 'package:vault/Utils/vault_manager.dart';

class MultiCardPage extends StatelessWidget {
  final VaultCard parentCard;

  const MultiCardPage({super.key, required this.parentCard});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(parentCard.account),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
      ),
      floatingActionButton: CircularMenu(
        alignment: Alignment.bottomRight,
        toggleButtonAnimatedIconData: AnimatedIcons.add_event,
        toggleButtonBoxShadow: [],
        items: [
          CircularMenuItem(
            boxShadow: [],
            icon: Icons.add_card,
            onTap: () => showDialog(
              context: context,
              builder: (_) => CardCreatorDialog(
                isMultiCard: false,
                parentId: parentCard.id,
              ),
            ),
          ),
          CircularMenuItem(
            boxShadow: [],
            icon: Icons.library_add,
            onTap: () => showDialog(
              context: context,
              builder: (_) => CardCreatorDialog(
                isMultiCard: true,
                parentId: parentCard.id,
              ),
            ),
          )
        ],
      ),
      body: Consumer<VaultManager>(builder: (context, manager, _) {
        return ListView.builder(
            itemCount: parentCard.subCards.length,
            itemBuilder: (context, index) {
              final card = parentCard.subCards[index];
              return CardItem(
                card: card,
                onTap: () => card.isMultiCard
                    ? navigateToMultiCard(context, card)
                    : showCardDetails(context, card),
              );
            });
      }),
    );
  }
}
