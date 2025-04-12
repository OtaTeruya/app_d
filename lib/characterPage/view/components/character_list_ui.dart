import 'package:app_d/characterPage/view/components/character_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/character.dart';
import '../../utils/character_manager.dart';
import 'character_list.dart';

class CharacterListUI extends StatelessWidget {
  final CharacterListUIState uiState;
  final CharacterListCallback callback;
  final CharacterManager characterData = CharacterManager();

  CharacterListUI({super.key, required this.uiState, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Text(AppLocalizations.of(context)!.choose_a_creature),
          Expanded(
            child: ListView(
              children: [
                for (var character in uiState.characters)
                  ListTile(
                    title: Opacity(
                      opacity:
                          uiState.chosenCharacter.id == character.id
                              ? 1.0
                              : 0.3,
                      child: CharacterProfile(
                        character: character,
                        characterLevel: character.level,
                        onClick: () => callback.chooseCharacter(character),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CharacterListUIState {
  final Character chosenCharacter;
  final List<Character> characters;

  CharacterListUIState({
    required this.chosenCharacter,
    required this.characters,
  });
}
