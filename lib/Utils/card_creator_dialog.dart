import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:vault/Utils/vault_card.dart';
import 'package:vault/Utils/vault_manager.dart';

class CardCreatorDialog extends StatefulWidget {
  final bool isMultiCard;
  final String? parentId;

  const CardCreatorDialog({
    super.key,
    this.parentId,
    required this.isMultiCard,
  });

  @override
  State<CardCreatorDialog> createState() => _CardCreatorDialogState();
}

class _CardCreatorDialogState extends State<CardCreatorDialog> {
  final Uuid uuid = const Uuid();

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Create ${widget.isMultiCard ? 'Multi' : 'Simple'} Card',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Account Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              if (!widget.isMultiCard) ...[
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
              ],
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveCard,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveCard() {
    if (_formKey.currentState!.validate()) {
      final newCard = VaultCard(
        id: uuid.v4(),
        account: _titleController.text,
        password: widget.isMultiCard ? null : _passwordController.text,
        isMultiCard: widget.isMultiCard,
        subCards: widget.isMultiCard ? [] : null,
      );

      final manager = context.read<VaultManager>();
      manager.addCard(newCard, widget.parentId);

      Navigator.pop(context);
    }
  }
}
