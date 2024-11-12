import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class IconAnimatedButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  final double height;
  final double borderRadius;
  final TextStyle? labelStyle;
  final double? iconSize;
  final EdgeInsetsGeometry padding;
  final bool disabled;
  final double? width;
  final Duration animationDuration;
  final BorderRadius? customBorderRadius;
  final double backgroundOpacity;
  final double borderOpacity;
  final double borderWidth;
  final List<BoxShadow>? boxShadow;
  final bool showShadowOnlyOnHover;
  final Color? hoverColor;
  final Color? activeColor;
  final bool expandOnHover;
  final VoidCallback? onLongPress;
  final Curve animationCurve;
  final double? minWidth;
  final double spaceBetween;
  final bool alwaysShowLabel;
  final Widget? customIcon;
  final bool reverseAnimationOnDeactivate;
  final bool enableFeedback;
  final String? tooltip;

  const IconAnimatedButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.color,
    this.height = 50,
    this.borderRadius = 12,
    this.labelStyle,
    this.iconSize = 18,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    this.disabled = false,
    this.width,
    this.animationDuration = const Duration(milliseconds: 200),
    this.customBorderRadius,
    this.backgroundOpacity = 0.1,
    this.borderOpacity = 0.2,
    this.borderWidth = 1,
    this.boxShadow,
    this.showShadowOnlyOnHover = false,
    this.hoverColor,
    this.activeColor,
    this.expandOnHover = true,
    this.onLongPress,
    this.animationCurve = Curves.easeInOut,
    this.minWidth,
    this.spaceBetween = 8,
    this.alwaysShowLabel = false,
    this.customIcon,
    this.reverseAnimationOnDeactivate = true,
    this.enableFeedback = true,
    this.tooltip,
  });

  @override
  State<IconAnimatedButton> createState() => _IconAnimatedButtonState();
}

class _IconAnimatedButtonState extends State<IconAnimatedButton>
    with SingleTickerProviderStateMixin {
  bool _isActive = false;
  bool _isHovered = false;

  void _handleTapDown(TapDownDetails details) {
    if (!widget.disabled) {
      setState(() => _isActive = true);
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.disabled) {
      setState(() => _isActive = false);
      widget.onPressed();
    }
  }

  void _handleTapCancel() {
    if (!widget.disabled) {
      setState(() => _isActive = false);
    }
  }

  void _handleHover(bool isHovered) {
    if (!widget.disabled) {
      setState(() => _isHovered = isHovered);
      if (kIsWeb && widget.expandOnHover) {
        setState(() => _isActive = isHovered);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor = widget.color ?? theme.colorScheme.primary;
    final effectiveActiveColor = widget.activeColor ?? buttonColor;
    final effectiveHoverColor = widget.hoverColor ?? buttonColor;

    final bool showLabel = widget.alwaysShowLabel || _isActive;
    final bool showShadow = !widget.showShadowOnlyOnHover || _isHovered;

    final defaultLabelStyle = TextStyle(
      color: _isActive ? Colors.white : buttonColor,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    final effectiveLabelStyle = widget.labelStyle?.copyWith(
          color: _isActive ? Colors.white : buttonColor,
        ) ??
        defaultLabelStyle;

    Widget buttonContent = Container(
      width: widget.width,
      height: widget.height,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: _isActive
            ? effectiveActiveColor
            : (_isHovered
                ? effectiveHoverColor
                    .withOpacity(widget.backgroundOpacity * 1.5)
                : buttonColor.withOpacity(widget.backgroundOpacity)),
        borderRadius: widget.customBorderRadius ??
            BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: buttonColor.withOpacity(_isActive ? 0 : widget.borderOpacity),
          width: widget.borderWidth,
        ),
        boxShadow: showShadow ? widget.boxShadow : null,
      ),
      child: Row(
        mainAxisSize:
            widget.width != null ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.customIcon ??
              Icon(
                widget.icon,
                color: _isActive ? Colors.white : buttonColor,
                size: widget.iconSize,
              ),
          AnimatedContainer(
            duration: widget.animationDuration,
            curve: widget.animationCurve,
            width: showLabel ? widget.spaceBetween : 0,
          ),
          if (showLabel)
            AnimatedOpacity(
              duration: widget.animationDuration,
              curve: widget.animationCurve,
              opacity: showLabel ? 1.0 : 0.0,
              child: Text(
                widget.label,
                style: effectiveLabelStyle,
              ),
            ),
        ],
      ),
    );

    if (widget.tooltip != null) {
      buttonContent = Tooltip(
        message: widget.tooltip!,
        child: buttonContent,
      );
    }

    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onLongPress: widget.disabled ? null : widget.onLongPress,
        child: AnimatedOpacity(
          duration: widget.animationDuration,
          opacity: widget.disabled ? 0.6 : 1.0,
          child: AnimatedContainer(
            duration: widget.animationDuration,
            curve: widget.animationCurve,
            constraints: BoxConstraints(
              minWidth: widget.minWidth ?? 0,
            ),
            child: buttonContent,
          ),
        ),
      ),
    );
  }
}

// Extension for quick button variants
extension IconAnimatedButtonVariants on IconAnimatedButton {
  static IconAnimatedButton circular({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    Color? color,
    double size = 50,
    double? iconSize,
  }) {
    return IconAnimatedButton(
      icon: icon,
      label: label,
      onPressed: onPressed,
      color: color,
      height: size,
      width: size,
      iconSize: iconSize ?? size * 0.4,
      borderRadius: size / 2,
      expandOnHover: false,
      padding: EdgeInsets.zero,
    );
  }

  static IconAnimatedButton minimal({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    Color? color,
  }) {
    return IconAnimatedButton(
      icon: icon,
      label: label,
      onPressed: onPressed,
      color: color,
      backgroundOpacity: 0.05,
      borderWidth: 0,
      boxShadow: [],
    );
  }
}
