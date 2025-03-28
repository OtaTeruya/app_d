import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RewardDialog extends StatelessWidget {
  const RewardDialog({super.key, required this.nextPath});
  final String nextPath;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(
              'えさを手に入れました！',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          Gap(3),
          SizedBox(height: 150, child: Image.asset("images/hamburger.png")),
        ],
      ),
      content: Text('モンスターの様子を見に行きますか？'),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: Text('いいえ', style: TextStyle(color: Colors.blue)),
              onTap: () {
                context.go(nextPath);
              },
            ),
            GestureDetector(
              child: Text('様子を見に行く', style: TextStyle(color: Colors.blue)),
              onTap: () {
                context.go('/characterPage');
              },
            ),
          ],
        ),
      ],
    );
  }
}
