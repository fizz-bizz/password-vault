import 'package:flutter/material.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:provider/provider.dart';
import 'package:vault/Pages/settings_page.dart';
import 'package:vault/Utils/card_creator_dialog.dart';
import 'package:vault/Utils/card_item.dart';
import 'package:vault/Utils/edit_card_dialog.dart';
import 'package:vault/Utils/navigate_to_multicard.dart';
import 'package:vault/Utils/show_card_details.dart';
import 'package:vault/Utils/vault_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('V A U L T'),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SettingsPage(),
                        ),
                      ),
                  icon: const Icon(Icons.settings)),
            ),
          ],
        ),
        floatingActionButton: CircularMenu(
          alignment: Alignment.bottomRight,
          toggleButtonAnimatedIconData: AnimatedIcons.add_event,
          curve: Curves.easeInOut,
          toggleButtonBoxShadow: [
            BoxShadow(
              color: Colors.purpleAccent.withAlpha(200),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
            BoxShadow(
              color: Colors.blueAccent.withAlpha(200),
              spreadRadius: 3,
              blurRadius: 6,
              offset: const Offset(0, -1),
            ),
          ],
          items: [
            CircularMenuItem(
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withAlpha(250),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 0),
                ),
              ],
              icon: Icons.add_card,
              onTap: () => showDialog(
                context: context,
                builder: (_) => CardCreatorDialog(
                  isMultiCard: false,
                ),
              ),
            ),
            CircularMenuItem(
              boxShadow: [
                BoxShadow(
                  color: Colors.purpleAccent.withAlpha(250),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 1),
                ),
              ],
              icon: Icons.library_add,
              onTap: () => showDialog(
                context: context,
                builder: (_) => CardCreatorDialog(
                  isMultiCard: true,
                ),
              ),
            ),
          ],
        ),
        body: Consumer<VaultManager>(
          builder: (context, manager, _) {
            return ListView.builder(
                itemCount: manager.mainCards.length,
                itemBuilder: (context, index) {
                  final card = manager.mainCards[index];
                  return CardItem(
                    card: card,
                    onTap: () => card.isMultiCard
                        ? navigateToMultiCard(context, card)
                        : showCardDetails(context, card),
                    onLongPress: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.edit),
                              title: const Text('Edit'),
                              onTap: () {
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (_) => EditCardDialog(card: card),
                                );
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.delete),
                              title: const Text('Delete'),
                              onTap: () {
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Delete Card'),
                                    content: const Text(
                                        'Are you sure you want to delete this card?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          manager.deleteCard(card);
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      );
                    },
                  );
                });
          },
        ));
  }
}
