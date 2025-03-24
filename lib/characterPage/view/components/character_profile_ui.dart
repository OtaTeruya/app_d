import 'package:flutter/material.dart';

import '../../utils/character.dart';
import 'character_profile.dart';

class CharacterProfileUI extends StatelessWidget {
  final CharacterProfileUIState uiState;
  final CharacterProfileCallback callback;

  const CharacterProfileUI({
    super.key,
    required this.uiState,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => callback.onClick(),
      style: ElevatedButton.styleFrom(
        elevation: 4,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                color: uiState.character.color,
              ),
              SizedBox(width: 12),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              uiState.character.name,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black
                              )
                          ),
                          Text(
                              "${uiState.character.level}/${uiState.character.maxLevel}",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black
                              )
                          ),
                        ],
                      ),
                      LinearProgressIndicator(
                        value: uiState.character.level/uiState.character.maxLevel,
                        backgroundColor: Colors.black12,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        minHeight: 8,
                      ),
                    ],
                  )
              ),
            ],
          )
      ),
    );
  }
}

class CharacterProfileUIState {
  final Character character;

  CharacterProfileUIState({
    required this.character,
  });
}