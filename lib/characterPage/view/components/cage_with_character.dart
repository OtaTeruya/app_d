import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../utils/character.dart';
import '../character_page.dart';
import 'cage_with_character_ui.dart';

class CageWithCharacter extends StatefulWidget {
  final double cageSize;
  final Character character;
  final CharacterPageCallback callback;
  const CageWithCharacter({super.key, required this.cageSize, required this.character, required this.callback});

  @override
  State<CageWithCharacter> createState() => _CageWithCharacter();
}

class _CageWithCharacter
    extends State<CageWithCharacter>
    with SingleTickerProviderStateMixin
    implements CageWithCharacterCallback {
  late double topPosition;
  late double leftPosition;
  late double cageSize;

  late Timer _timer;
  late AnimationController _rotationController;

  bool isFeeding = false;
  double foodTopPosition = 0.0;
  double foodLeftPosition = 0.0;

  @override
  void initState() {
    super.initState();
    cageSize = widget.cageSize;

    //初期位置の決定
    topPosition = _randomPosition();
    leftPosition = _randomPosition();

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      while (true) {
        //食事が行われたら食事を終える
        if (isFeeding) {
          isFeeding = false;
          return;
        }

        //次の移動場所を決める
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


    // AnimationControllerの初期化
    _rotationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    );
  }

  // ランダムな位置を生成
  double _randomPosition() {
    return Random().nextDouble() * (cageSize - widget.character.size);
  }

  @override
  void cageTapped(Offset tappedPosition) {
    if (isFeeding) {
      return;//cage内に食事が置かれている場合はタップを受け付けない
    }

    // タップ位置に基づいて位置を更新
    double newT = tappedPosition.dy - (widget.character.size / 2);
    newT = newT.clamp(0, cageSize - widget.character.size);
    double newL = tappedPosition.dx - (widget.character.size / 2);
    newL = newL.clamp(0, cageSize - widget.character.size);
    setState(() {
      topPosition = newT;
      leftPosition = newL;
    });

    bool isFeedingSucceeded = widget.callback.feedingFood();
    if (isFeedingSucceeded) {//餌やりが行われた場合
      setState(() {
        isFeeding = true;
        foodTopPosition = newT;
        foodLeftPosition = newL;
      });
    }
  }

  @override
  void characterTapped() {
    // 回転アニメーションを実行
    _rotationController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _timer.cancel();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CageWithCharacterUI(
        uiState: CageWithCharacterUIState(
            topPosition: topPosition,
            leftPosition: leftPosition,
            cageSize: cageSize,
            character: widget.character,
            isFeeding: isFeeding,
            foodTopPosition: foodTopPosition,
            foodLeftPosition: foodLeftPosition,
            rotationController: _rotationController
        ),
        callback: this
    );
  }
}

abstract class CageWithCharacterCallback {
  void cageTapped(Offset tappedPosition);
  void characterTapped();
}