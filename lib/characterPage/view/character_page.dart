import 'package:app_d/characterPage/utils/character_manager.dart';
import 'package:app_d/characterPage/utils/food_manager.dart';
import 'package:app_d/home/view/home.dart';
import 'package:flutter/material.dart';

import '../utils/character.dart';
import 'character_page_ui.dart';

class CharacterPage extends StatefulWidget {
  final int? foodCount;
  final HomeCallback callback;
  const CharacterPage({super.key, required this.foodCount, required this.callback});

  @override
  State<CharacterPage> createState() => _CharacterPage();
}

class _CharacterPage extends State<CharacterPage> implements CharacterPageCallback {
  Character? chosenCharacter;
  int? chosenCharacterLevel;
  bool isCharacterListUIVisible = false;

  @override
  void initState() {
    super.initState();
    _loadChosenCharacter();
  }

  Future<void> _loadChosenCharacter() async {
    final character = await CharacterManager().loadChosenCharacter();
    setState(() {
      chosenCharacter = character;
      chosenCharacterLevel = character.level;
    });
  }

  @override
  bool feedingFood() {
    if (widget.foodCount == null || chosenCharacter == null || chosenCharacterLevel == null) {
      return false;
    }
    if (widget.foodCount! <= 0) {
      return false;
    }
    if (chosenCharacterLevel! >= chosenCharacter!.maxLevel) {
      return false;
    }

    FoodManager().subtractSavedFoodCount();
    CharacterManager().addSavedCharacterLevel(chosenCharacter!.id);
    setState(() {
      widget.callback.updateCharacterPageByEatingFood();
      chosenCharacterLevel = chosenCharacterLevel! + 1;
    });
    return true;
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
    CharacterManager().saveChosenCharacter(character);
    setState(() {
      chosenCharacter = character;
      chosenCharacterLevel = character.level;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (chosenCharacter == null || widget.foodCount == null) {
      return Center(child: CircularProgressIndicator());
    }

    return CharacterPageUI(
        uiState: CharacterPageUIState(
            chosenCharacter: chosenCharacter!,
            chosenCharacterLevel: chosenCharacterLevel!,
            foodCount: widget.foodCount!,
            isCharacterListUIVisible: isCharacterListUIVisible
        ),
        callback: this
    );
  }
}

abstract class CharacterPageCallback {
  bool feedingFood();
  void showCharacterListUI();
  void hideCharacterListUI();
  void chooseCharacter(Character character);
}