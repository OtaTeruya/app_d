import 'package:flutter/cupertino.dart';

import '../../utils/character.dart';
import '../character_page.dart';
import 'character_list_ui.dart';

class CharacterList extends StatefulWidget {
  final Character chosenCharacter;
  final CharacterPageCallback callback;
  const CharacterList({super.key, required this.chosenCharacter, required this.callback});

  @override
  State<CharacterList> createState() => _CharacterList();
}

class _CharacterList extends State<CharacterList> implements CharacterListCallback {
  @override
  void chooseCharacter(Character character) {
    widget.callback.chooseCharacter(character);
  }

  @override
  void hideCharacterListUI() {
    widget.callback.hideCharacterListUI();
  }

  @override
  Widget build(BuildContext context) {
    return CharacterListUI(
        uiState: CharacterListUIState(
            chosenCharacter: widget.chosenCharacter
        ),
        callback: this
    );
  }
}

abstract class CharacterListCallback {
  void chooseCharacter(Character character);
  void hideCharacterListUI();
}