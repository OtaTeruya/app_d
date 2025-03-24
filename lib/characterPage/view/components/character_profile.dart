import 'package:flutter/cupertino.dart';

import '../../utils/character.dart';
import 'character_profile_ui.dart';

class CharacterProfile extends StatefulWidget {
  final Character character;
  final void Function() onClick;
  const CharacterProfile({super.key, required this.character, required this.onClick});

  @override
  State<CharacterProfile> createState() => _CharacterProfile();
}

class _CharacterProfile extends State<CharacterProfile> implements CharacterProfileCallback {
  @override
  void onClick() {
    widget.onClick();
  }

  @override
  Widget build(BuildContext context) {
    return CharacterProfileUI(
        uiState: CharacterProfileUIState(character: widget.character),
        callback: this
    );
  }
}

abstract class CharacterProfileCallback {
  void onClick();
}