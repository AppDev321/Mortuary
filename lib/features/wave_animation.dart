import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaveLoadingScreen extends StatefulWidget {
  const WaveLoadingScreen({Key? key}) : super(key: key);

  @override
  _WaveLoadingScreenState createState() => _WaveLoadingScreenState();
}

class _WaveLoadingScreenState extends State<WaveLoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Animated wave widget
          Positioned.fill(
            bottom: 0,
            child: WaveWidget(
              config: CustomConfig(
                gradients: [
                  [Colors.blue, Colors.blue], // Single blue color
                ],
                durations: [5000],
                heightPercentages: [_animation.value], // Dynamically adjust the height
                blur: MaskFilter.blur(BlurStyle.solid, 10),
                gradientBegin: Alignment.bottomCenter, // Start from the bottom
                gradientEnd: Alignment.topCenter, // End at the top
              ),
              waveAmplitude: 0,
              backgroundColor: Colors.transparent,
              size: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height,
              ),
              wavePhase: 0,
            ),
          ),
        ],
      ),
    );
  }
}
