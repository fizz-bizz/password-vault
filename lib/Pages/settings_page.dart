import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
// import 'package:vault/Utils/backup_password_dialog.dart';
import 'package:vault/Utils/vault_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final vaultManager = Provider.of<VaultManager>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.upload),
            title: const Text('Export Backup'),
            onTap: () => _exportBackup(context, vaultManager),
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Import Backup'),
            onTap: () => _importBackup(context, vaultManager),
          ),
        ],
      ),
    );
  }

  Future<void> _exportBackup(BuildContext context, VaultManager manager) async {
    try {
      final String? path = await FilePicker.platform.getDirectoryPath();
      if (path == null || !context.mounted) return;

      await manager.exportBackup(path);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Backup exported successfully!')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export failed: ${e.toString()}')),
      );
    }
  }

  Future<void> _importBackup(BuildContext context, VaultManager manager) async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null || !context.mounted) return;

      final filePath = result.files.single.path!;
      await manager.importBackup(filePath);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Backup imported successfully!')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Import failed: ${e.toString()}')),
      );
    }
  }
}
