import 'dart:async';

import 'package:flutter/material.dart';

class TypingAnimationText extends StatefulWidget {
  const TypingAnimationText(
    this.text, {
    super.key,
    this.duration = const Duration(milliseconds: 100),
    this.style = const TextStyle(fontSize: 32),
  });

  final String text;
  final Duration duration;
  final TextStyle style;

  @override
  State<TypingAnimationText> createState() => TypingAnimationTextState();
}

class TypingAnimationTextState extends State<TypingAnimationText> {
  Timer? _timer;
  int _index = 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTypingAnimation() {
    _timer?.cancel();
    _index = 0;

    _timer = Timer.periodic(widget.duration, (timer) {
      if (_index < widget.text.length) {
        setState(() {
          _index++;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text.substring(0, _index),
      style: widget.style,
    );
  }
}