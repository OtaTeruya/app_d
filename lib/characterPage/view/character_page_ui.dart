import 'package:app_d/characterPage/utils/character.dart';
import 'package:app_d/characterPage/view/components/cage_with_character.dart';
import 'package:app_d/characterPage/view/components/character_list.dart';
import 'package:app_d/characterPage/view/components/character_profile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'character_page.dart';

class CharacterPageUI extends StatelessWidget {
  final CharacterPageUIState uiState;
  final CharacterPageCallback callback;

  const CharacterPageUI({
    super.key,
    required this.uiState,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Gap(8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Image.asset(
                        "images/hamburger.png",
                        width: 32,
                        height: 32,
                      ),
                      Text(
                        "× ${uiState.foodCount}",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ],
                  ),
                  Gap(8),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return CageWithCharacter(
                          character: uiState.chosenCharacter,
                          cageHeight: constraints.maxHeight,
                          cageWidth: constraints.maxWidth,
                          callback: callback,
                        );
                      },
                    ),
                  ),
                  Gap(20),
                  CharacterProfile(
                    character: uiState.chosenCharacter,
                    characterLevel: uiState.chosenCharacterLevel,
                    onClick: () => callback.showCharacterListUI(),
                  ),
                  Gap(40),
                ],
              ),
            ),

            Visibility(
              visible: uiState.isCharacterListUIVisible,
              child: CharacterList(
                chosenCharacter: uiState.chosenCharacter,
                callback: callback,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CharacterPageUIState {
  final Character chosenCharacter;
  final int chosenCharacterLevel;
  final int foodCount;
  final bool isCharacterListUIVisible;

  CharacterPageUIState({
    required this.chosenCharacter,
    required this.chosenCharacterLevel,
    required this.foodCount,
    required this.isCharacterListUIVisible,
  });
}
