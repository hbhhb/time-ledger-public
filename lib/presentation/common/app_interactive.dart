import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:time_ledger/core/theme/foundations/app_tokens.dart';

enum AppInteractionStyle {
  normal,
  light,
  strong,
}

class AnimationConfig {
  final double mass;
  final double stiffness;
  final double damping;
  final Duration? duration;
  final Curve? curve;

  const AnimationConfig.spring({
    this.mass = 1.0,
    this.stiffness = 711.1,
    this.damping = 40.0,
  })  : duration = null,
        curve = null;

  const AnimationConfig.curve({
    required this.duration,
    required this.curve,
  })  : mass = 1.0,
        stiffness = 1.0, // Unused
        damping = 1.0; // Unused
}

class InteractionState {
  final bool isHovered;
  final bool isFocused;
  final bool isPressed;

  const InteractionState({
    this.isHovered = false,
    this.isFocused = false,
    this.isPressed = false,
  });
}

class AppInteractive extends StatefulWidget {
  final Widget? child;
  final Widget Function(BuildContext context, InteractionState state)? builder;
  final VoidCallback? onTap;
  final AppInteractionStyle style;
  final double scaleFactor;
  final AnimationConfig animationConfig;
  final BorderRadius? borderRadius;
  final bool hapticEnabled;
  final VoidCallback? hapticFeedback;

  const AppInteractive({
    super.key,
    required this.child,
    this.onTap,
    this.style = AppInteractionStyle.normal,
    this.scaleFactor = 0.95,
    this.animationConfig = const AnimationConfig.spring(),
    this.borderRadius,
    this.hapticEnabled = false,
    this.hapticFeedback,
  }) : builder = null;

  const AppInteractive.builder({
    super.key,
    required this.builder,
    this.onTap,
    this.style = AppInteractionStyle.normal,
    this.scaleFactor = 0.95,
    this.animationConfig = const AnimationConfig.spring(),
    this.hapticEnabled = false,
    this.hapticFeedback,
  })  : child = null,
        borderRadius = null;

  @override
  State<AppInteractive> createState() => _AppInteractiveState();
}

class _AppInteractiveState extends State<AppInteractive> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool _isHovered = false;
  bool _isFocused = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: widget.animationConfig.duration ?? const Duration(milliseconds: 200));
    _controller.value = 1.0; // Initial scale 1.0

    _updateAnimation();
  }

  @override
  void didUpdateWidget(AppInteractive oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationConfig != oldWidget.animationConfig || widget.scaleFactor != oldWidget.scaleFactor) {
      _updateAnimation();
    }
  }

  void _updateAnimation() {
    // Basic setup, actual simulation run on press
  }

  void _runScaleAnimation(bool isPressed) {
    final double target = isPressed ? widget.scaleFactor : 1.0;

    if (widget.animationConfig.duration != null && widget.animationConfig.curve != null) {
      // Duration + Curve animation
      _controller.animateTo(target, curve: widget.animationConfig.curve!, duration: widget.animationConfig.duration!);
    } else {
      // Spring animation
      final spring = SpringDescription(
        mass: widget.animationConfig.mass,
        stiffness: widget.animationConfig.stiffness,
        damping: widget.animationConfig.damping,
      );

      final simulation = SpringSimulation(spring, _controller.value, target, 0);
      _controller.animateWith(simulation);
    }
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.hapticEnabled) {
      if (widget.hapticFeedback != null) {
        widget.hapticFeedback!();
      } else {
        HapticFeedback.lightImpact();
      }
    }
    setState(() => _isPressed = true);
    _runScaleAnimation(true);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _runScaleAnimation(false);
    widget.onTap?.call();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _runScaleAnimation(false);
  }

  void _handleHover(bool isHovered) {
    if (_isHovered != isHovered) {
      setState(() => _isHovered = isHovered);
    }
  }

  void _handleFocus(bool isFocused) {
    if (_isFocused != isFocused) {
      setState(() => _isFocused = isFocused);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = InteractionState(
      isHovered: _isHovered,
      isFocused: _isFocused,
      isPressed: _isPressed,
    );

    final Widget content = widget.builder?.call(context, state) ??
        Stack(
          children: [
            widget.child!,
            Positioned.fill(
              child: AppInteractiveOverlay(
                style: widget.style,
                state: state,
                borderRadius: widget.borderRadius,
              ),
            ),
          ],
        );

    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: FocusableActionDetector(
        onShowFocusHighlight: _handleFocus,
        child: GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,

          onTapCancel: _handleTapCancel,
          behavior: HitTestBehavior.opaque, // Ensure entire area is clickable
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _controller.value,
                child: child,
              );
            },
            child: content,
          ),
        ),
      ),
    );
  }
}

class AppInteractiveOverlay extends StatelessWidget {
  final AppInteractionStyle style;
  final InteractionState state;
  final BorderRadius? borderRadius;

  const AppInteractiveOverlay({
    super.key,
    required this.style,
    required this.state,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    // Resolve color
    final appColors = Theme.of(context).extension<AppColors>();
    // If AppColors is not in theme, fallback (should not happen in real app but safe for isolation)
    final overlayColor = appColors?.labelNormal ?? Colors.black;

    // Resolve opacity
    // Assuming AppOpacity usage strategy: Use AppOpacity.values() factory since it's constant-based.
    // If integrated into Theme, could use extension. For now, use factory.
    final opacities = AppOpacity.values();

    double opacity = 0.0;
    switch (style) {
      case AppInteractionStyle.normal:
        if (state.isPressed) {
          opacity = opacities.pressedNormal;
        } else if (state.isFocused) {
          opacity = opacities.focusedNormal;
        } else if (state.isHovered) {
          opacity = opacities.hoverNormal;
        }
        break;
      case AppInteractionStyle.light:
        if (state.isPressed) {
          opacity = opacities.pressedLight;
        } else if (state.isFocused) {
          opacity = opacities.focusedLight;
        } else if (state.isHovered) {
          opacity = opacities.hoverLight;
        }
        break;
      case AppInteractionStyle.strong:
        if (state.isPressed) {
          opacity = opacities.pressedStrong;
        } else if (state.isFocused) {
          opacity = opacities.focusedStrong;
        } else if (state.isHovered) {
          opacity = opacities.hoverStrong;
        }
        break;
    }

    return IgnorePointer(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: overlayColor.withValues(alpha: opacity),
          borderRadius: borderRadius ?? BorderRadius.circular(0),
        ),
      ),
    );
  }
}
