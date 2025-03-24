class Character {
  final int id;
  final String name;
  final String imagePath;
  late final int level;
  final int maxLevel;
  final double size;
  final double minDist;
  final double maxDist;

  Character({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.level,
    required this.maxLevel,
    required this.size,
    required this.minDist,
    required this.maxDist,
  });
}