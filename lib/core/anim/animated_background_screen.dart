import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  final List<Color> colors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final Duration duration;

  const AnimatedBackground({super.key,
    required this.colors,
    this.begin = Alignment.bottomCenter,
    this.end = Alignment.topCenter,
    this.duration = const Duration(seconds: 2),
  });

  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with TickerProviderStateMixin {
  late List<Color> colorList;
  late AlignmentGeometry begin;
  late AlignmentGeometry end;
  late Duration duration;

  int index = 0;
  late Color bottomColor;
  late Color topColor;

  @override
  void initState() {
    super.initState();
    colorList = widget.colors;
    begin = widget.begin;
    end = widget.end;
    duration = widget.duration;

    bottomColor = colorList[0];
    topColor = colorList[1];

    Timer.periodic(duration, (timer) {
      setState(() {
        index = (index + 1) % colorList.length;
        bottomColor = colorList[index];
        topColor = colorList[(index + 1) % colorList.length];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: [bottomColor, topColor],
        ),
      ),
    );
  }
}
