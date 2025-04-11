import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RewardDialog extends StatelessWidget {
  final VoidCallback moveToCharacterPage;
  const RewardDialog({super.key, required this.moveToCharacterPage});

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
                Navigator.of(context).pop();
                },
            ),
            GestureDetector(
              child: Text('様子を見に行く', style: TextStyle(color: Colors.blue)),
              onTap: () {
                Navigator.of(context).pop();
                moveToCharacterPage();
              },
            ),
          ],
        ),
      ],
    );
  }
}
