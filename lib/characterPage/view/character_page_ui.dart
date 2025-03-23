import 'package:app_d/characterPage/utils/character.dart';
import 'package:app_d/characterPage/view/components/cage_with_character.dart';
import 'package:app_d/characterPage/view/components/character_list.dart';
import 'package:app_d/characterPage/view/components/character_profile.dart';
import 'package:flutter/material.dart';

import '../../custom_app_bar.dart';
import 'character_page.dart';

class CharacterPageUI extends StatelessWidget {
  final CharacterPageUIState uiState;
  final CharacterPageCallback callback;

  const CharacterPageUI({
    super.key,
    required this.uiState,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'CharacterPage'),
        body:Center(
            child: Stack(
                children: [
                  Column(
                      children: [
                        TextButton(
                            onPressed: () => callback.moveToHomePage(context),
                            child: Text('HomePageへ')
                        ),
                        TextButton(
                            onPressed: () => callback.showCharacterListUI(),
                            child: Text('CharacterListUIの表示')
                        ),
                        CageWithCharacter(
                          cageSize: MediaQuery.of(context).size.width-40,
                          character: uiState.chosenCharacter,
                        ),
                        CharacterProfile(character: uiState.chosenCharacter)
                      ]
                  ),
                  
                  Visibility(
                      visible: uiState.isCharacterListUIVisible,
                      child: CharacterList(
                          chosenCharacter: uiState.chosenCharacter,
                          callback: callback
                      )
                  )
                ]
            )
        )
    );
  }
}

class CharacterPageUIState {
  final Character chosenCharacter;
  final bool isCharacterListUIVisible;

  CharacterPageUIState({
    required this.chosenCharacter,
    required this.isCharacterListUIVisible
  });
}