import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final ValueNotifier<DateTime> selectedDate;

  const Calendar({super.key, required this.selectedDate});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2024, 1, 1),
          lastDay: DateTime.utc(2050, 1, 1),
          focusedDay: selectedDate.value,
          locale: 'ja_JP',
          selectedDayPredicate: (day) => isSameDay(selectedDate.value, day),
          onDaySelected: (selectedDay, focusedDay) {
            selectedDate.value = selectedDay;
          },
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Colors.blue, // 選択された日付の背景色
              shape: BoxShape.circle, // 丸い形にする
            ),
          ),
        ),
      ],
    );
  }
}
