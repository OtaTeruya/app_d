import 'package:app_d/characterPage/utils/character_manager.dart';
import 'package:app_d/characterPage/utils/food_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/character.dart';
import 'character_page_ui.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPage();
}

class _CharacterPage extends State<CharacterPage> implements CharacterPageCallback {
  Character? chosenCharacter;
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
    });
  }

  Future<void> _loadFoodCount() async {
    final cnt = await FoodManager().loadFoodCount();
    setState(() {
      foodCount = cnt;
    });
  }

  @override
  void moveToHomePage(BuildContext context) {
    context.go('/homePage');
  }

  @override
  bool feedingFood() {
    if (foodCount == null) {
      return false;
    }
    if (foodCount! <= 0) {
      return false;
    }

    FoodManager().subtractSavedFoodCount();
    setState(() {
      foodCount = foodCount! - 1;
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
            foodCount: foodCount!,
            isCharacterListUIVisible: isCharacterListUIVisible
        ),
        callback: this
    );
  }
}

abstract class CharacterPageCallback {
  void moveToHomePage(BuildContext context);
  bool feedingFood();
  void showCharacterListUI();
  void hideCharacterListUI();
  void chooseCharacter(Character character);
}