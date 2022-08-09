library overflow_text;

import 'dart:async';

import 'package:flutter/material.dart';

class OverflowTextWidget extends StatefulWidget {
  const OverflowTextWidget({
    Key? key,
    required this.text,
    this.waitDuration = const Duration(seconds: 2),
    this.animationDuration = const Duration(seconds: 3),
  }) : super(key: key);

  /// The Text Widget that will be displayed.
  final Text text;

  /// The amount of waiting time between translation animation repetition.
  final Duration waitDuration;

  /// The duration that a single animation will take to finish.
  final Duration animationDuration;
  @override
  _OverflowTextWidgetState createState() => _OverflowTextWidgetState();
}

class _OverflowTextWidgetState extends State<OverflowTextWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: widget.animationDuration,
  );

  late Text text = widget.text;

  Size _textSize(Text text) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text.data, style: text.style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  @override
  void initState() {
    super.initState();
    Timer(widget.waitDuration, () {
      controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Timer(widget.waitDuration, () {
            controller.reset();
            controller.forward();
          });
        }
      });
      controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: Row(
        children: List<Widget>.generate(
          MediaQuery.of(context).size.width ~/ _textSize(text).width * 2,
              (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: text,
            );
          },
        ),
      ),
      builder: (context, child) {
        var sz = _textSize(text);
        return Transform.translate(
          offset: Offset(-controller.value, 0) * (sz.width + 10),
          child: child,
        );
      },
    );
  }
}