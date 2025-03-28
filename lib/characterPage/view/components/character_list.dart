import 'package:flutter/material.dart';

import '../../utils/character.dart';
import '../../utils/character_manager.dart';
import '../character_page.dart';
import 'character_list_ui.dart';

class CharacterList extends StatefulWidget {
  final Character chosenCharacter;
  final CharacterPageCallback callback;
  const CharacterList({
    super.key,
    required this.chosenCharacter,
    required this.callback,
  });

  @override
  State<CharacterList> createState() => _CharacterList();
}

class _CharacterList extends State<CharacterList>
    implements CharacterListCallback {
  List<Character>? characters;

  @override
  void initState() {
    super.initState();
    _getCharacters();
  }

  Future<void> _getCharacters() async {
    final characters = await CharacterManager().getCharacters();
    setState(() {
      this.characters = characters;
    });
  }

  @override
  void chooseCharacter(Character character) {
    widget.callback.chooseCharacter(character);
    widget.callback.hideCharacterListUI();
  }

  @override
  Widget build(BuildContext context) {
    if (characters == null) {
      return Center(child: CircularProgressIndicator());
    }

    return CharacterListUI(
      uiState: CharacterListUIState(
        chosenCharacter: widget.chosenCharacter,
        characters: characters!,
      ),
      callback: this,
    );
  }
}

abstract class CharacterListCallback {
  void chooseCharacter(Character character);
}
