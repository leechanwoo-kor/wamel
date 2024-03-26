import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wamel/wamel/game_over.dart';
import 'package:wamel/wamel/menu.dart';
import 'package:wamel/wamel/wamel_game.dart';

class WamelWidget extends StatelessWidget {
  const WamelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      textTheme: TextTheme(
        displayLarge: GoogleFonts.sriracha(
          fontSize: 35,
          color: Colors.white,
        ),
        labelLarge: GoogleFonts.sriracha(
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: GoogleFonts.sriracha(
          fontSize: 28,
          color: Colors.grey,
        ),
        bodyMedium: GoogleFonts.sriracha(
          fontSize: 18,
          color: Colors.grey,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          minimumSize: const Size(150, 50),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hoverColor: Colors.red.shade700,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red.shade700,
          ),
        ),
      ),
    );

    return MaterialApp(
      title: 'Watermelon',
      home: GameWidget<WamelGame>(
        game: WamelGame(),
        loadingBuilder: (context) => Center(
          child: Text(
            'Loading...',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        overlayBuilderMap: {
          'menu': (_, game) => Menu(game),
          'game_over': (_, game) => GameOver(game),
        },
        initialActiveOverlays: const ['menu'],
      ),
      theme: theme,
    );
  }
}
