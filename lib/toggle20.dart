import 'dart:ui';
import 'package:flutter/material.dart';

class CustomToggle extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const CustomToggle({
    super.key,
    this.initialValue = false,
    this.onChanged,
  });

  @override
  State<CustomToggle> createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle>
    with TickerProviderStateMixin {
  late bool isToggled;
  late double left;
  late double top;

  double scale = 1.0;
  bool _isAnimating = false;

  final double toggleWidth = 120;
  final double toggleHeight = 120;
  final double buttonWidth = 40;
  final double buttonHeight = 28;
  final double padding = 12;

  late AnimationController _moveController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _leftAnimation;
  late Animation<double> _topAnimation;

  @override
  void initState() {
    super.initState();
    isToggled = widget.initialValue;
    _setInitialPosition();

    _moveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _setupAnimations();
  }

  void _setInitialPosition() {
    left = isToggled ? toggleWidth - buttonWidth - padding : padding;
    top = isToggled ? toggleHeight - buttonHeight - padding : padding;
  }

  void _setupAnimations() {
    final midLeft = toggleWidth / 2 - buttonWidth / 2;
    final midTop = toggleHeight / 2 - buttonHeight / 2;

    final finalLeft = isToggled ? padding : toggleWidth - buttonWidth - padding;
    final finalTop = isToggled ? padding : toggleHeight - buttonHeight - padding;

    _leftAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: left, end: midLeft), weight: 40),
      TweenSequenceItem(tween: Tween(begin: midLeft, end: finalLeft), weight: 60),
    ]).animate(CurvedAnimation(
      parent: _moveController,
      curve: Curves.easeInOutQuart,
    ));

    _topAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: top, end: midTop), weight: 40),
      TweenSequenceItem(tween: Tween(begin: midTop, end: finalTop), weight: 60),
    ]).animate(CurvedAnimation(
      parent: _moveController,
      curve: Curves.easeInOutQuart,
    ));

    _scaleAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.8), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.8, end: 1.15), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.15, end: 1.0), weight: 20),
    ]).animate(CurvedAnimation(
      parent: _moveController,
      curve: Curves.easeInOutCubic,
    ));

    _moveController.addListener(() {
      setState(() {
        left = _leftAnimation.value;
        top = _topAnimation.value;
        scale = _scaleAnimation.value;
      });
    });

    _moveController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isAnimating = false;
      }
    });
  }

  void animateSmoothToggle() {
    if (_isAnimating) return; // Ignore if already animating
    _isAnimating = true;

    // Immediately flip toggle state
    isToggled = !isToggled;
    widget.onChanged?.call(isToggled);
    _setupAnimations();
    _moveController.forward(from: 0);
  }

  @override
  void dispose() {
    _moveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: animateSmoothToggle,
      child: Container(
        width: toggleWidth,
        height: toggleHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.12),
              Colors.white.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.transparent),
              ),
              Positioned(
                left: left,
                top: top,
                child: Transform.scale(
                  scale: scale,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.6),
                              Colors.white.withOpacity(0.3),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
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
