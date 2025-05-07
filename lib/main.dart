import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals_app/views/tabs.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 131, 75, 0),
    brightness: Brightness.dark,
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Meals App', theme: theme, home: TabsScreen());
  }
}
