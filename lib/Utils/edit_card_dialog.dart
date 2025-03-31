import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vault/Utils/vault_card.dart';
import 'package:vault/Utils/vault_manager.dart';

class EditCardDialog extends StatefulWidget {
  final VaultCard card;

  const EditCardDialog({super.key, required this.card});

  @override
  State<EditCardDialog> createState() => _EditCardDialogState();
}

class _EditCardDialogState extends State<EditCardDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _passwordController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.card.account);
    _passwordController =
        TextEditingController(text: widget.card.password ?? '');
  }

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
                'Edit Card',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Account Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              if (!widget.card.isMultiCard) ...[
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscurePassword,
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
      final manager = context.read<VaultManager>();
      widget.card.account = _titleController.text;
      if (!widget.card.isMultiCard) {
        widget.card.password = _passwordController.text;
      }
      manager.updateCard(widget.card);
      Navigator.pop(context);
    }
  }
}
