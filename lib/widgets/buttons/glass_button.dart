import 'dart:ui';

import 'package:flutter/material.dart';

class GlassButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final double height;
  final double borderRadius;
  final Color? color;
  final double blurAmount;
  final TextStyle? labelStyle;
  final double? iconSize;
  final EdgeInsetsGeometry padding;
  final bool disabled;
  final double? width;
  final MainAxisAlignment mainAxisAlignment;
  final double opacity;
  final double borderOpacity;
  final double borderWidth;
  final IconData? suffixIcon;
  final double iconSpacing;

  const GlassButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.height = 50,
    this.borderRadius = 12,
    this.color,
    this.blurAmount = 10,
    this.labelStyle,
    this.iconSize = 18,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.disabled = false,
    this.width,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.opacity = 0.1,
    this.borderOpacity = 0.2,
    this.borderWidth = 1,
    this.suffixIcon,
    this.iconSpacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor = color ?? theme.colorScheme.primary;

    final effectiveLabelStyle = theme.textTheme.labelLarge
        ?.copyWith(
          color: buttonColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        )
        .merge(labelStyle);

    return Opacity(
      opacity: disabled ? 0.6 : 1.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurAmount,
            sigmaY: blurAmount,
          ),
          child: Container(
            width: width,
            height: height,
            padding: padding,
            decoration: BoxDecoration(
              color: buttonColor.withOpacity(opacity),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: buttonColor.withOpacity(borderOpacity),
                width: borderWidth,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: disabled ? null : onPressed,
                borderRadius: BorderRadius.circular(borderRadius),
                child: Row(
                  mainAxisSize:
                      width != null ? MainAxisSize.max : MainAxisSize.min,
                  mainAxisAlignment: mainAxisAlignment,
                  children: [
                    if (icon != null) ...[
                      Icon(
                        icon,
                        color: buttonColor,
                        size: iconSize,
                      ),
                      SizedBox(width: iconSpacing),
                    ],
                    Text(
                      label,
                      style: effectiveLabelStyle,
                    ),
                    if (suffixIcon != null) ...[
                      SizedBox(width: iconSpacing),
                      Icon(
                        suffixIcon,
                        color: buttonColor,
                        size: iconSize,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
