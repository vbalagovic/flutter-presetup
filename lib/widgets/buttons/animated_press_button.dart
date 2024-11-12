import 'package:flutter/material.dart';

class AnimatedPressButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  final IconData? icon;
  final double height;
  final double borderRadius;
  final Duration animationDuration;
  final double scaleAmount;
  final TextStyle? labelStyle;
  final double? iconSize;
  final EdgeInsetsGeometry padding;
  final bool disabled;
  final BoxShadow? customShadow;
  final double? width;
  final MainAxisAlignment mainAxisAlignment;
  final IconData? suffixIcon;
  final double iconSpacing;

  const AnimatedPressButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.icon,
    this.height = 50,
    this.borderRadius = 12,
    this.animationDuration = const Duration(milliseconds: 150),
    this.scaleAmount = 0.95,
    this.labelStyle,
    this.iconSize = 18,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.disabled = false,
    this.customShadow,
    this.width,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.suffixIcon,
    this.iconSpacing = 8,
  });

  @override
  State<AnimatedPressButton> createState() => _AnimatedPressButtonState();
}

class _AnimatedPressButtonState extends State<AnimatedPressButton>
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

    final defaultShadow = BoxShadow(
      color: buttonColor.withOpacity(0.3),
      blurRadius: 12,
      offset: const Offset(0, 6),
    );

    final effectiveLabelStyle = theme.textTheme.labelLarge
        ?.copyWith(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        )
        .merge(widget.labelStyle);

    return Opacity(
      opacity: widget.disabled ? 0.6 : 1.0,
      child: GestureDetector(
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
              width: widget.width,
              height: widget.height,
              padding: widget.padding,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                boxShadow: [widget.customShadow ?? defaultShadow],
              ),
              child: Row(
                mainAxisSize:
                    widget.width != null ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: widget.mainAxisAlignment,
                children: [
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      color: Colors.white,
                      size: widget.iconSize,
                    ),
                    SizedBox(width: widget.iconSpacing),
                  ],
                  Text(
                    widget.label,
                    style: effectiveLabelStyle,
                  ),
                  if (widget.suffixIcon != null) ...[
                    SizedBox(width: widget.iconSpacing),
                    Icon(
                      widget.suffixIcon,
                      color: Colors.white,
                      size: widget.iconSize,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
