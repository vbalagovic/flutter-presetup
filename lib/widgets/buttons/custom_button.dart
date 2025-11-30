import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double? width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double borderWidth;
  final TextStyle? labelStyle;
  final double? iconSize;
  final MainAxisSize mainAxisSize;
  final bool isLoading;
  final Widget? loadingWidget;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final bool disabled;
  final double? elevation;
  final double iconSpacing;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.width,
    this.height = 50,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth = 1,
    this.labelStyle,
    this.iconSize = 18,
    this.mainAxisSize = MainAxisSize.min,
    this.isLoading = false,
    this.loadingWidget,
    this.border,
    this.boxShadow,
    this.disabled = false,
    this.elevation,
    this.iconSpacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBackgroundColor =
        backgroundColor ?? theme.colorScheme.primary;
    final effectiveForegroundColor = foregroundColor ?? Colors.white;

    final defaultLoadingWidget = SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(effectiveForegroundColor),
      ),
    );

    final effectiveTextStyle = theme.textTheme.labelLarge
        ?.copyWith(
          color: effectiveForegroundColor,
          fontWeight: FontWeight.w600,
        )
        .merge(labelStyle);

    return Material(
      color: Colors.transparent,
      elevation: elevation ?? 0,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: (disabled || isLoading) ? null : onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Opacity(
          opacity: disabled ? 0.6 : 1.0,
          child: Container(
            width: width,
            height: height,
            padding: padding,
            decoration: BoxDecoration(
              color: effectiveBackgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: border ??
                  (borderColor != null
                      ? Border.all(color: borderColor!, width: borderWidth)
                      : null),
              boxShadow: boxShadow,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: mainAxisSize,
              children: [
                if (isLoading) ...[
                  loadingWidget ?? defaultLoadingWidget,
                ] else ...[
                  if (prefixIcon != null) ...[
                    Icon(
                      prefixIcon,
                      color: effectiveForegroundColor,
                      size: iconSize,
                    ),
                    SizedBox(width: iconSpacing),
                  ],
                  Text(
                    label,
                    style: effectiveTextStyle,
                  ),
                  if (suffixIcon != null) ...[
                    SizedBox(width: iconSpacing),
                    Icon(
                      suffixIcon,
                      color: effectiveForegroundColor,
                      size: iconSize,
                    ),
                  ],
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Factory constructor for creating an outlined version of the button
  factory CustomButton.outlined({
    required String label,
    required VoidCallback? onPressed,
    Color? color,
    IconData? prefixIcon,
    IconData? suffixIcon,
    double? width,
    double height = 50,
    bool isLoading = false,
    bool disabled = false,
    TextStyle? labelStyle,
  }) {
    return CustomButton(
      label: label,
      onPressed: onPressed,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      width: width,
      height: height,
      backgroundColor: Colors.transparent,
      foregroundColor: color,
      borderColor: color,
      labelStyle: labelStyle,
      isLoading: isLoading,
      disabled: disabled,
    );
  }

  /// Factory constructor for creating a text-only version of the button
  factory CustomButton.text({
    required String label,
    required VoidCallback? onPressed,
    Color? color,
    IconData? prefixIcon,
    IconData? suffixIcon,
    TextStyle? labelStyle,
    bool isLoading = false,
    bool disabled = false,
  }) {
    return CustomButton(
      label: label,
      onPressed: onPressed,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      backgroundColor: Colors.transparent,
      foregroundColor: color,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      labelStyle: labelStyle,
      isLoading: isLoading,
      disabled: disabled,
    );
  }
}
