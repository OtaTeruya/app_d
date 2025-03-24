import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../custom_app_bar.dart';
import 'history_page.dart';

class HistoryPageUI extends StatelessWidget {
  final HistoryPageUIState uiState;
  final HistoryPageCallback callback;

  final ValueNotifier<DateTime> _selectedDate = ValueNotifier(DateTime.now());

  HistoryPageUI({super.key, required this.uiState, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'HistoryPage'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          children: [
            TextButton(
              onPressed: () => callback.moveToHomePage(context),
              child: Text('HomePageへ'),
            ),
            TableCalendar(
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2050, 1, 1),
              focusedDay: _selectedDate.value,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDate.value, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                _selectedDate.value = selectedDay;
              },
            ),
            Center(
              child: ValueListenableBuilder<DateTime>(
                valueListenable: _selectedDate,
                builder: (context, date, child) {
                  return Text('${date.year}年${date.month}月${date.day}日');
                },
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class HistoryPageUIState {
  final int uiNoZyoutai1;
  final String uiNoZyoutai2;

  HistoryPageUIState({required this.uiNoZyoutai1, required this.uiNoZyoutai2});
}
