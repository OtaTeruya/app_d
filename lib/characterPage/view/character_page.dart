import 'package:app_d/characterPage/utils/character_manager.dart';
import 'package:app_d/characterPage/utils/food_manager.dart';
import 'package:flutter/material.dart';

import '../utils/character.dart';
import 'character_page_ui.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPage();
}

class _CharacterPage extends State<CharacterPage> implements CharacterPageCallback {
  Character? chosenCharacter;
  int? chosenCharacterLevel;
  int? foodCount;
  bool isCharacterListUIVisible = false;

  @override
  void initState() {
    super.initState();
    _loadChosenCharacter();
    _loadFoodCount();
  }

  Future<void> _loadChosenCharacter() async {
    final character = await CharacterManager().loadChosenCharacter();
    setState(() {
      chosenCharacter = character;
      chosenCharacterLevel = character.level;
    });
  }

  Future<void> _loadFoodCount() async {
    final cnt = await FoodManager().loadFoodCount();
    setState(() {
      foodCount = cnt;
    });
  }

  @override
  bool feedingFood() {
    if (foodCount == null || chosenCharacter == null || chosenCharacterLevel == null) {
      return false;
    }
    if (foodCount! <= 0) {
      return false;
    }
    if (chosenCharacterLevel! >= chosenCharacter!.maxLevel) {
      return false;
    }

    FoodManager().subtractSavedFoodCount();
    CharacterManager().addSavedCharacterLevel(chosenCharacter!.id);
    setState(() {
      foodCount = foodCount! - 1;
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
    if (chosenCharacter == null || foodCount == null) {
      return Center(child: CircularProgressIndicator());
    }

    return CharacterPageUI(
        uiState: CharacterPageUIState(
            chosenCharacter: chosenCharacter!,
            chosenCharacterLevel: chosenCharacterLevel!,
            foodCount: foodCount!,
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