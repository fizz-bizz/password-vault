import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vault/Pages/homepage.dart';
import 'package:vault/Utils/vault_manager.dart';
import 'package:vault/Hive/hive_encryption_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveEncryptionService.init();

  runApp(
    FutureBuilder(
        future: VaultManager().initialize(),
        builder: (context, snapshot) {
          return ChangeNotifierProvider(
            create: (context) => VaultManager()..initialize(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.dark(),
              home: const HomePage(),
            ),
          );
        }),
  );
}
