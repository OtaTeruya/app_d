import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final ValueNotifier<DateTime> selectedDate;
  

  const Calendar({
    super.key,
    required this.selectedDate,
    
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DateTime>(
      valueListenable: selectedDate,
      builder: (context, date, child) {
        return TableCalendar(
          firstDay: DateTime.utc(2024, 1, 1),
          lastDay: DateTime.utc(2050, 1, 1),
          focusedDay: date,
          locale: 'ja_JP',
          selectedDayPredicate: (day) => isSameDay(date, day),
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(selectedDate.value, selectedDay)) {
              selectedDate.value = selectedDay; // 値が変わるときのみ更新
            }
          },

          
        );
      },
    );
  }
}
