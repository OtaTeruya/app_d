class Character {
  final String name;
  final String imagePath;
  final int level;
  final int maxLevel;
  final double size;
  final double minDist;
  final double maxDist;

  Character({
    this.name = "あかしかく",
    this.imagePath = "",
    this.level = 1,
    this.maxLevel = 10,
    this.size = 30.0,
    this.minDist = 60.0,
    this.maxDist = 180.0,
  });
}