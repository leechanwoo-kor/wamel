import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Image, Gradient;
import 'package:url_launcher/url_launcher.dart';
import 'package:wamel/wamel/game_colors.dart';
import 'package:wamel/wamel/menu_card.dart';
import 'package:wamel/wamel/wamel_game.dart';

class Menu extends StatelessWidget {
  const Menu(this.game, {super.key});

  final WamelGame game;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Wrap(
          children: [
            Column(
              children: [
                MenuCard(
                  children: [
                    Text(
                      'Watermelon',
                      style: textTheme.displayLarge,
                    ),
                    Text(
                      'Make watermelon to win',
                      style: textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      child: const Text('1 Player'),
                      onPressed: () {
                        game.prepareStart(numberOfPlayers: 1);
                      },
                    ),
                    Text(
                      'Arrow keys',
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      child: const Text('2 Players'),
                      onPressed: () {
                        game.prepareStart(numberOfPlayers: 2);
                      },
                    ),
                    Text(
                      'WASD',
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
                MenuCard(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Made by ',
                            style: textTheme.bodyMedium,
                          ),
                          TextSpan(
                            text: 'Charles Lee',
                            style: textTheme.bodyMedium?.copyWith(
                              color: GameColors.green.color,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(
                                  Uri.parse(
                                      'https://github.com/leechanwoo-kor/'),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
