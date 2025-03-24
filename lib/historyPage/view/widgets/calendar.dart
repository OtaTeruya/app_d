import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final ValueNotifier<DateTime> _selectedDate = ValueNotifier(DateTime.now());
  Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2024, 1, 1),
          lastDay: DateTime.utc(2050, 1, 1),
          focusedDay: _selectedDate.value,
          locale: 'ja_JP',
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDate.value, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            _selectedDate.value = selectedDay;
          },
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Colors.blue, // 選択された日付の背景色
              shape: BoxShape.circle, // 丸い形にする
            ),
          ),
        ),
        Center(
          child: ValueListenableBuilder<DateTime>(
            valueListenable: _selectedDate,
            builder: (context, date, child) {
              return Text('${date.year}年${date.month}月${date.day}日');
            },
          ),
        ),
      ],
    );
  }
}
