import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../history_page.dart';

class Calendar extends StatelessWidget {
  final DateTime selectedDate;
  final HistoryPageCallback callback;

  const Calendar({
    super.key,
    required this.selectedDate,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true
      ),
      calendarStyle: CalendarStyle(
        cellMargin: EdgeInsets.zero,
        cellPadding: EdgeInsets.all(4),
        todayDecoration: BoxDecoration(
          color: Color(0xFF7F7F7F),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Color(0xFF547F54),
          shape: BoxShape.circle,
        ),
      ),
      rowHeight: 42,
      daysOfWeekHeight: 28,
      firstDay: DateTime.utc(2024, 1, 1),
      lastDay: DateTime.utc(2050, 1, 1),
      focusedDay: selectedDate,
      locale: 'ja_JP',
      selectedDayPredicate: (day) => isSameDay(selectedDate, day),
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(selectedDate, selectedDay)) {
          callback.selectDate(selectedDay);
        }
      },
    );
  }
}
