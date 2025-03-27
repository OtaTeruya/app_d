import 'package:flutter/material.dart';

import 'home_page.dart';

class HomePageUI extends StatefulWidget {
  final HomePageDataState uiState;
  final HomePageCallback callback;

  const HomePageUI({super.key, required this.uiState, required this.callback});

  @override
  HomePageUIState createState() => HomePageUIState();
}

class HomePageUIState extends State<HomePageUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF669966),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 160),
            Text(
              "もぐもぐ帳",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 32),
            Expanded(child: Container(child: _charactersBox())),
            _menuButton(
              () => widget.callback.moveToCapturePage(context),
              '食事の写真を撮る',
            ),
            SizedBox(height: 28),
            _menuButton(
              () => widget.callback.moveToHistoryPage(context),
              '履歴を見る',
            ),
            SizedBox(height: 28),
            _menuButton(
              () => widget.callback.moveToCharacterPage(context),
              'モンスターに会いに行く',
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _menuButton(VoidCallback onPressed, String text) {
    return SizedBox(
      width: 280,
      height: 48,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF669966),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(text, style: TextStyle(fontSize: 18)),
      ),
    );
  }

  Widget _charactersBox() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset("images/character2.png"),
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset("images/character4.png"),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset("images/character1.png"),
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset("images/character3.png"),
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset("images/character5.png"),
            ),
          ],
        ),
      ],
    );
  }
}

class HomePageDataState {
  final int uiNoZyoutai1;
  final String uiNoZyoutai2;

  HomePageDataState({required this.uiNoZyoutai1, required this.uiNoZyoutai2});
}
