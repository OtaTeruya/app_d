import 'package:app_d/characterPage/utils/character.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CharacterManager {
  final List<Character> _characters = [
    Character(id: 0, name: "みずいろ", imagePath: "images/character1.png", level: 1, maxLevel: 10, size: 80, minDist: 60, maxDist: 180),
    Character(id: 1, name: "むらさき", imagePath: "images/character2.png", level: 1, maxLevel: 10, size: 80, minDist: 60, maxDist: 180),
    Character(id: 2, name: "あお", imagePath: "images/character3.png", level: 1, maxLevel: 10, size: 80, minDist: 20, maxDist: 100),
    Character(id: 3, name: "おれんじ", imagePath: "images/character4.png", level: 1, maxLevel: 10, size: 80, minDist: 120, maxDist: 240),
    Character(id: 4, name: "みどり", imagePath: "images/character5.png", level: 1, maxLevel: 10, size: 60, minDist: 60, maxDist: 180),
  ];

  List<Character> getCharacters() {
    return _characters;
  }

  Character _getCharacter(int id) {
    return _characters.firstWhere(
          (character) => character.id == id,
      orElse: () => _characters[0],  // 見つからなければ0番目のCharacterを返す
    );
  }

  String chosenCharacterIdKey = "chosen_character_id";
  Future<Character> loadChosenCharacter() async {
    final prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt(chosenCharacterIdKey) ?? 0;
    return _getCharacter(id);
  }

  Future<void> saveChosenCharacter(Character character) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(chosenCharacterIdKey, character.id);
  }
}