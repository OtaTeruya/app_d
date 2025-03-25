import 'package:app_d/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MealForm extends StatefulWidget {
  const MealForm({super.key, required this.imgPath});
  final String imgPath;

  @override
  State<MealForm> createState() => _MealFormState();
}

class _MealFormState extends State<MealForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'CapturePage'),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () => context.go('/homePage'),
              child: Text('HomePageへ'),
            ),
            TextButton(
              onPressed: () => context.go('/historyPage'),
              child: Text('HistoryPageへ'),
            ),
          ],
        ),
      ),
    );
  }
}
