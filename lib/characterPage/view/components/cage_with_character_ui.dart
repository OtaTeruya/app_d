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
              AnimatedPositioned(
                duration: const Duration(milliseconds: 1000),
                top: uiState.topPosition,
                left: uiState.leftPosition,
                child: Container(
                  width: uiState.characterSize,
                  height: uiState.characterSize,
                  color: Colors.red,
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
  late double cageSize;
  final double characterSize;

  CageWithCharacterUIState({
    required this.topPosition,
    required this.leftPosition,
    required this.cageSize,
    required this.characterSize,
  });
}