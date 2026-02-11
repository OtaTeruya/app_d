import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RewardDialog extends StatelessWidget {
  final VoidCallback moveToCharacterPage;
  const RewardDialog({super.key, required this.moveToCharacterPage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.you_got_food,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Gap(3),
          SizedBox(height: 150, child: Image.asset("images/hamburger.png")),
        ],
      ),
      content: Text(AppLocalizations.of(context)!.visit_creature),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              child: Text(
                  AppLocalizations.of(context)!.no,
                  style: TextStyle(color: Colors.blue)
              ),
              onTap: () {
                Navigator.of(context).pop();
                },
            ),
            GestureDetector(
              child: Text(
                  AppLocalizations.of(context)!.yes,
                  style: TextStyle(color: Colors.blue)
              ),
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
