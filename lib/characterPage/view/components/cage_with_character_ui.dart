import 'package:app_d/characterPage/utils/character.dart';
import 'package:flutter/material.dart';

import 'cage_with_character.dart';

class CageWithCharacterUI extends StatelessWidget {
  final CageWithCharacterUIState uiState;
  final CageWithCharacterCallback callback;

  const CageWithCharacterUI({
    super.key,
    required this.uiState,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTapDown: (TapDownDetails details) {
          callback.cageTapped(details.localPosition);
        },
        child: Container(
          width: uiState.cageSize,
          height: uiState.cageSize,
          color: Colors.blue[50],
          child: Stack(
            children: [
              Visibility(
                  visible: uiState.isFeeding,
                  child: Positioned(//食べ物の位置を管理
                    top: uiState.foodTopPosition,
                    left: uiState.foodLeftPosition,
                    child: Image.asset(
                      "images/hamburger.png",
                      width: 32,
                      height: 32,
                    ),
                  )
              ),
              AnimatedPositioned(//キャラクターの位置を管理
                duration: const Duration(milliseconds: 1000),
                top: uiState.topPosition,
                left: uiState.leftPosition,
                child: GestureDetector(
                  onTap: callback.characterTapped,
                  child: AnimatedBuilder(
                    animation: uiState.rotationController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: uiState.rotationController.value * 2 * 3.1415,
                        child: child,
                      );
                    },
                    child: Image.asset(
                      uiState.character.imagePath,
                      width: uiState.character.size,
                      height: uiState.character.size,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CageWithCharacterUIState {
  final double topPosition;
  final double leftPosition;
  final double cageSize;
  final Character character;
  final bool isFeeding;
  final double foodTopPosition;
  final double foodLeftPosition;
  final AnimationController rotationController;

  CageWithCharacterUIState({
    required this.topPosition,
    required this.leftPosition,
    required this.cageSize,
    required this.character,
    required this.isFeeding,
    required this.foodTopPosition,
    required this.foodLeftPosition,
    required this.rotationController
  });
}