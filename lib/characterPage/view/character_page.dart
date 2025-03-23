import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../utils/character.dart';
import 'character_page_ui.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPage();
}

class _CharacterPage extends State<CharacterPage> implements CharacterPageCallback {
  Character chosenCharacter = Character();

  @override
  void moveToHomePage(BuildContext context) {
    context.go('/homePage');
  }

  @override
  Widget build(BuildContext context) {
    return CharacterPageUI(
        uiState: CharacterPageUIState(chosenCharacter: chosenCharacter),
        callback: this
    );
  }
}

abstract class CharacterPageCallback {
  void moveToHomePage(BuildContext context);
}