import 'package:shared_preferences/shared_preferences.dart';

class FoodManager {
  String foodCountKey = "food_count";
  Future<int> loadFoodCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(foodCountKey) ?? 5;
  }

  Future<bool> addSavedFoodCount() async {
    DateTime nowDate = DateTime.now();
    int now = _convertDateTimeToInt(nowDate);
    int last = await _loadLastDateInt();

    if (now - last < 120) {//2時間経過してなければ餌は手に入らない
      return false;
    }
    await _saveLastDateInt(now);

    int savedFoodCount = await loadFoodCount();
    await _saveFoodCount(savedFoodCount + 1);
    return true;
  }

  Future<void> subtractSavedFoodCount() async {
    int savedFoodCount = await loadFoodCount();
    _saveFoodCount(savedFoodCount - 1);
  }

  Future<void> _saveFoodCount(int foodCount) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(foodCountKey, foodCount);
  }

  String lastDateIntKey = "last_date_int";
  Future<int> _loadLastDateInt() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(lastDateIntKey) ?? 0;
  }

  Future<void> _saveLastDateInt(int lastDateInt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(lastDateIntKey, lastDateInt);
  }

  int _convertDateTimeToInt(DateTime dateTime) {
    int date = int.parse(
      '${dateTime.year}'
          '${dateTime.month.toString().padLeft(2, '0')}'
          '${dateTime.day.toString().padLeft(2, '0')}'
          '${dateTime.hour.toString().padLeft(2, '0')}'
          '${dateTime.minute.toString().padLeft(2, '0')}',
    );
    return date;
  }
}