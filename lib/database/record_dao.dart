import 'database_helper.dart';

class RecordDAO {
  Future<int> insertRecord(
    String path,
    int date,
    int time,
    String cuisine,
  ) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('records', {
      'path': path,
      'date': date,
      'time': time,
      'cuisine': cuisine,
    });
  }

  Future<Map<String, dynamic>?> getLatestRecord() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('records', orderBy: 'id DESC', limit: 1);

    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> getRecordsByDate(int date) async {
    final db = await DatabaseHelper.instance.database;
    return await db.query(
      'records',
      where: 'date = ?',
      whereArgs: [date],
      orderBy: 'time ASC',
    );
  }
}
