import 'package:flutter/material.dart';

class BouncingIconButton extends StatefulWidget {
  final IconData icon;
  final Color? color;
  final VoidCallback onPressed;
  final double size;
  final Duration animationDuration;
  final double scaleAmount;
  final double? iconSize;
  final bool disabled;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final String? tooltip;
  final double backgroundOpacity;

  const BouncingIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.size = 50,
    this.animationDuration = const Duration(milliseconds: 150),
    this.scaleAmount = 0.8,
    this.iconSize,
    this.disabled = false,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.tooltip,
    this.backgroundOpacity = 0.1,
  });

  @override
  State<BouncingIconButton> createState() => _BouncingIconButtonState();
}

class _BouncingIconButtonState extends State<BouncingIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: widget.scaleAmount).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor = widget.color ?? theme.colorScheme.primary;
    final effectiveBackgroundColor = widget.backgroundColor ??
        buttonColor.withOpacity(widget.backgroundOpacity);

    final button = GestureDetector(
      onTapDown: widget.disabled ? null : (_) => _controller.forward(),
      onTapUp: widget.disabled
          ? null
          : (_) {
              _controller.reverse();
              widget.onPressed();
            },
      onTapCancel: widget.disabled ? null : () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: effectiveBackgroundColor,
              borderRadius:
                  widget.borderRadius ?? BorderRadius.circular(widget.size / 2),
              border: widget.border,
              boxShadow: widget.boxShadow,
            ),
            child: Icon(
              widget.icon,
              color: buttonColor,
              size: widget.iconSize ?? widget.size * 0.5,
            ),
          ),
        ),
      ),
    );

    return Opacity(
      opacity: widget.disabled ? 0.6 : 1.0,
      child: widget.tooltip != null
          ? Tooltip(
              message: widget.tooltip!,
              child: button,
            )
          : button,
    );
  }
}
