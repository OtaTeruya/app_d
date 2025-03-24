import 'package:shared_preferences/shared_preferences.dart';

class FoodManager {
  String foodCountKey = "food_count";
  Future<int> loadFoodCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(foodCountKey) ?? 5;
  }

  Future<void> addSavedFoodCount() async {
    int savedFoodCount = await loadFoodCount();
    _saveFoodCount(savedFoodCount + 1);
  }

  Future<void> subtractSavedFoodCount() async {
    int savedFoodCount = await loadFoodCount();
    _saveFoodCount(savedFoodCount - 1);
  }

  Future<void> _saveFoodCount(int foodCount) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(foodCountKey, foodCount);
  }
}