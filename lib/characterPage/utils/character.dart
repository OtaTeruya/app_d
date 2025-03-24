import 'package:flutter/material.dart';

class Character {
  final int id;
  final String name;
  final Color color;
  final int level;
  final int maxLevel;
  final double size;
  final double minDist;
  final double maxDist;

  Character({
    required this.id,
    required this.name,
    required this.color,
    required this.level,
    required this.maxLevel,
    required this.size,
    required this.minDist,
    required this.maxDist,
  });
}