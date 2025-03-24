import 'package:app_d/characterPage/utils/character.dart';
import 'package:flutter/material.dart';

class CharacterData {
  final List<Character> _characters = [
    Character(id: 0, name: "あか", color: Colors.red, level: 1, maxLevel: 10, size: 20, minDist: 60, maxDist: 180),
    Character(id: 1, name: "あお", color: Colors.blue, level: 1, maxLevel: 10, size: 20, minDist: 60, maxDist: 180),
    Character(id: 2, name: "くろ", color: Colors.black, level: 1, maxLevel: 10, size: 60, minDist: 20, maxDist: 100),
    Character(id: 3, name: "きいろ", color: Colors.yellow, level: 1, maxLevel: 10, size: 10, minDist: 120, maxDist: 240),
    Character(id: 4, name: "みどり", color: Colors.green, level: 1, maxLevel: 10, size: 40, minDist: 60, maxDist: 180),
    Character(id: 5, name: "むらさき", color: Colors.purple, level: 1, maxLevel: 10, size: 20, minDist: 60, maxDist: 180),
  ];

  List<Character> getCharacters() {
    return _characters;
  }
}