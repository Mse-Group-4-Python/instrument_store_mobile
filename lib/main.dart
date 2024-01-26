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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        fontFamily: GoogleFonts.openSans().fontFamily,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
