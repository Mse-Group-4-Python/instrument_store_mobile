import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instrument_store_mobile/presentation/pages/home/home_page.dart';

import 'core/app_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppCore.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Instrument Store',
      debugShowCheckedModeBanner: false,
      transitionDuration: const Duration(milliseconds: 410),
      defaultTransition: Transition.fade,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        fontFamily: GoogleFonts.openSans().fontFamily,
        useMaterial3: true,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 12, 79, 112),
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          constraints: const BoxConstraints(
            minHeight: 48,
          ),
          fillColor: context.theme.colorScheme.surfaceVariant,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusColor: context.theme.colorScheme.surfaceVariant,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
