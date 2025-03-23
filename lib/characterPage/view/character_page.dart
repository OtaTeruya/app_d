import 'package:app_d/characterPage/utils/character_data.dart';
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
  Character chosenCharacter = CharacterData().getCharacters()[0];
  bool isCharacterListUIVisible = false;

  @override
  void moveToHomePage(BuildContext context) {
    context.go('/homePage');
  }

  @override
  void showCharacterListUI() {
    setState(() {
      isCharacterListUIVisible = true;
    });
  }

  @override
  void hideCharacterListUI() {
    setState(() {
      isCharacterListUIVisible = false;
    });
  }

  @override
  void chooseCharacter(Character character) {
    setState(() {
      chosenCharacter = character;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CharacterPageUI(
        uiState: CharacterPageUIState(
            chosenCharacter: chosenCharacter,
            isCharacterListUIVisible: isCharacterListUIVisible
        ),
        callback: this
    );
  }
}

abstract class CharacterPageCallback {
  void moveToHomePage(BuildContext context);
  void showCharacterListUI();
  void hideCharacterListUI();
  void chooseCharacter(Character character);
}