import 'package:app_d/characterPage/view/components/character_profile.dart';
import 'package:flutter/material.dart';

import '../../utils/character.dart';
import '../../utils/character_manager.dart';
import 'character_list.dart';

class CharacterListUI extends StatelessWidget {
  final CharacterListUIState uiState;
  final CharacterListCallback callback;
  final CharacterManager characterData = CharacterManager();

  CharacterListUI({
    super.key,
    required this.uiState,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
            children: [
              TextButton(
                  onPressed: () => callback.hideCharacterListUI(),
                  child: Text('CharacterListUIを隠す')
              ),
              Expanded(
                  child: ListView(
                      children: [
                        for (var character in characterData.getCharacters())
                          ListTile(
                              title: Opacity(
                                  opacity: uiState.chosenCharacter.id == character.id ? 1.0 : 0.3,
                                  child: CharacterProfile(
                                      character: character,
                                      onClick: () => callback.chooseCharacter(character)
                                  )
                              )
                          ),
                      ]
                  )
              )
            ]
        )
    );
  }
}

class CharacterListUIState {
  final Character chosenCharacter;

  CharacterListUIState({
    required this.chosenCharacter,
  });
}