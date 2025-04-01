import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vault/Pages/homepage.dart';
import 'package:vault/Utils/vault_manager.dart';
import 'package:vault/Hive/hive_encryption_service.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveEncryptionService.init();
  final vaultManager = VaultManager();
  await vaultManager.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (context) => vaultManager,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          textTheme: ThemeData.dark().textTheme.apply(
                fontFamily: GoogleFonts.montserrat().fontFamily,
              ),
          primaryTextTheme: ThemeData.dark().primaryTextTheme.apply(
                fontFamily: GoogleFonts.montserrat().fontFamily,
              ),
        ),
        home: const HomePage(),
      ),
    ),
  );
}
