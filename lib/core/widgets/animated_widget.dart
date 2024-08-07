
import 'package:flutter/material.dart';

enum AnimationType {
  SLIDE_FROM_LEFT,
  SLIDE_FROM_RIGHT,
  SLIDE_FROM_TOP,
  SLIDE_FROM_BOTTOM,
}

class CustomAnimatedWidget extends StatefulWidget {
  const CustomAnimatedWidget({
    Key? key,

    /// The Widget to be animated
    required this.child,

    /// Set the duration of the animation
    this.animationDuration = const Duration(milliseconds: 300),

    /// Set the duration of delay to start animation
    this.delayDuration = Duration.zero,

    /// Set the animation
    this.animation = AnimationType.SLIDE_FROM_BOTTOM,

    /// Set animation enabled/disbled
    this.enabled = true,
  }) : super(key: key);

  final Widget child;
  final Duration delayDuration;
  final Duration animationDuration;
  final AnimationType animation;
  final bool enabled;

  @override
  _CustomAnimatedWidgetState createState() => _CustomAnimatedWidgetState();
}

class _CustomAnimatedWidgetState extends State<CustomAnimatedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool isAnimationControllerDisposed = false;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    animation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(widget.delayDuration);
      if (widget.enabled && !isAnimationControllerDisposed) {
        animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: _offset(),
          child: Opacity(opacity: 1.0 - (animation.value), child: widget.child),
        );
      },
    );
  }

  Offset _offset() {
    double extent = 30.0;

    switch (widget.animation) {
      case AnimationType.SLIDE_FROM_LEFT:
        extent = extent - (extent * 2);

        return Offset(extent * animation.value, 0.0);

      case AnimationType.SLIDE_FROM_RIGHT:
        return Offset(extent * animation.value, 0.0);

      case AnimationType.SLIDE_FROM_TOP:
        extent = extent - (extent * 2);

        return Offset(0.0, extent * animation.value);

      case AnimationType.SLIDE_FROM_BOTTOM:
        return Offset(0.0, extent * animation.value);
    }
  }

  @override
  dispose() {
    animationController.dispose();
    isAnimationControllerDisposed = true;
    super.dispose();
  }
}