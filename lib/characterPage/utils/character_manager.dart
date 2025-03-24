import 'package:app_d/characterPage/utils/character.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CharacterManager {
  final List<_CharacterInfo> _characterInfos = [
    _CharacterInfo(id: 0, name: "みずいろ", imagePath: "images/character1.png", maxLevel: 10, size: 80, minDist: 60, maxDist: 180),
    _CharacterInfo(id: 1, name: "むらさき", imagePath: "images/character2.png", maxLevel: 10, size: 80, minDist: 60, maxDist: 180),
    _CharacterInfo(id: 2, name: "あお", imagePath: "images/character3.png", maxLevel: 10, size: 80, minDist: 20, maxDist: 100),
    _CharacterInfo(id: 3, name: "おれんじ", imagePath: "images/character4.png", maxLevel: 10, size: 80, minDist: 120, maxDist: 240),
    _CharacterInfo(id: 4, name: "みどり", imagePath: "images/character5.png", maxLevel: 10, size: 60, minDist: 60, maxDist: 180),
  ];

  Future<List<Character>> getCharacters() async {
    List<Character> characters = [];
    for (var characterInfo in _characterInfos) {
      int level = await loadCharacterLevel(characterInfo.id);
      characters.add(_makeCharacter(characterInfo, level));
    }
    return characters;
  }

  String characterLevelKey = "character_level";
  Future<int> loadCharacterLevel(int id) async {
    final prefs = await SharedPreferences.getInstance();
    int characterLevel = prefs.getInt(characterLevelKey + id.toString()) ?? 0;
    return characterLevel;
  }

  Future<void> addSavedCharacterLevel(int id) async {
    int level = await loadCharacterLevel(id);
    _saveCharacterLevel(id, level+1);
  }

  Future<void> _saveCharacterLevel(int id, int level) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(characterLevelKey + id.toString(), level);
  }

  Future<Character> _getCharacter(int id) async {
    _CharacterInfo characterInfo = _characterInfos.firstWhere(
          (character) => character.id == id,
      orElse: () => _characterInfos[0],
    );
    int level = await loadCharacterLevel(id);
    return _makeCharacter(characterInfo, level);
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

  Character _makeCharacter(_CharacterInfo characterInfo, int level) {
    return Character(
        id: characterInfo.id,
        name: characterInfo.name,
        imagePath: characterInfo.imagePath,
        level: level,
        maxLevel: characterInfo.maxLevel,
        size: characterInfo.size,
        minDist: characterInfo.minDist,
        maxDist: characterInfo.maxDist
    );
  }
}

class _CharacterInfo {//Characterクラスのレベル情報を持たない版。
  final int id;
  final String name;
  final String imagePath;
  final int maxLevel;
  final double size;
  final double minDist;
  final double maxDist;

  _CharacterInfo({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.maxLevel,
    required this.size,
    required this.minDist,
    required this.maxDist,
  });
}