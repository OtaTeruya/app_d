import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../utils/character.dart';
import 'cage_with_character_ui.dart';

class CageWithCharacter extends StatefulWidget {
  final double cageSize;
  final Character character;
  const CageWithCharacter({super.key, required this.cageSize, required this.character});

  @override
  State<CageWithCharacter> createState() => _CageWithCharacter();
}

class _CageWithCharacter extends State<CageWithCharacter> implements CageWithCharacterCallback {
  late double topPosition;
  late double leftPosition;
  late double cageSize;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    cageSize = widget.cageSize;

    //初期位置の決定
    topPosition = _randomPosition();
    leftPosition = _randomPosition();

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      //次の移動場所を決める
      while (true) {
        double newT = _randomPosition();
        double newL = _randomPosition();
        double squaredDist = (pow(newT - topPosition, 2) + pow(newL - leftPosition, 2)).toDouble();

        if (pow(widget.character.minDist, 2) < squaredDist && squaredDist < pow(widget.character.maxDist, 2)) {
          //minDist~maxDistの距離を移動するならOK
          setState(() {
            topPosition = newT;
            leftPosition = newL;
          });
          break;
        }
      }
    });
  }

  // ランダムな位置を生成
  double _randomPosition() {
    return Random().nextDouble() * (cageSize - widget.character.size);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void cageTapped(Offset tappedPosition) {
    // タップ位置に基づいて位置を更新
    double newT = tappedPosition.dy - (widget.character.size / 2);
    double newL = tappedPosition.dx - (widget.character.size / 2);

    // cageの範囲を超えないように制限
    setState(() {
      topPosition = newT.clamp(0, cageSize - widget.character.size);
      leftPosition = newL.clamp(0, cageSize - widget.character.size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CageWithCharacterUI(
        uiState: CageWithCharacterUIState(
            topPosition: topPosition,
            leftPosition: leftPosition,
            cageSize: cageSize,
            character: widget.character
        ),
        callback: this
    );
  }
}

abstract class CageWithCharacterCallback {
  void cageTapped(Offset tappedPosition);
}