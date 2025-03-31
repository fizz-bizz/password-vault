import 'package:flutter/material.dart';

class BackupPasswordDialog extends StatelessWidget {
  final bool isExport;
  const BackupPasswordDialog({super.key, required this.isExport});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return AlertDialog(
      title: Text(isExport ? 'Set Backup Password' : 'Enter Backup Password'),
      content: TextField(
        controller: controller,
        obscureText: true,
        decoration: const InputDecoration(hintText: 'Password'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, controller.text),
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
