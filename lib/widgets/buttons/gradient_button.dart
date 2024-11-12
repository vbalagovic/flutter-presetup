import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final List<Color>? gradientColors;
  final double height;
  final bool isLoading;
  final double borderRadius;
  final TextStyle? labelStyle;
  final double? iconSize;
  final EdgeInsetsGeometry padding;
  final bool disabled;
  final double? width;
  final MainAxisAlignment mainAxisAlignment;
  final Alignment gradientBegin;
  final Alignment gradientEnd;
  final List<BoxShadow>? boxShadow;
  final Widget? loadingWidget;
  final double iconSpacing;
  final Border? border;
  final double? elevation;
  final Duration? animationDuration;
  final Widget? customChild;
  final bool showShadowOnlyOnHover;
  final double backgroundBlendOpacity;
  final Color? overlayColor;
  final double? loadingSize;
  final Color? loadingColor;
  final double loadingStrokeWidth;
  final Gradient? customGradient;
  final VoidCallback? onLongPress;
  final BorderRadius? customBorderRadius;

  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.gradientColors,
    this.height = 50,
    this.isLoading = false,
    this.borderRadius = 12,
    this.labelStyle,
    this.iconSize = 18,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.disabled = false,
    this.width,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.gradientBegin = Alignment.centerLeft,
    this.gradientEnd = Alignment.centerRight,
    this.boxShadow,
    this.loadingWidget,
    this.iconSpacing = 8,
    this.border,
    this.elevation,
    this.animationDuration,
    this.customChild,
    this.showShadowOnlyOnHover = false,
    this.backgroundBlendOpacity = 1.0,
    this.overlayColor,
    this.loadingSize = 24,
    this.loadingColor,
    this.loadingStrokeWidth = 3,
    this.customGradient,
    this.onLongPress,
    this.customBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultGradient = [
      theme.colorScheme.primary,
      Color.lerp(theme.colorScheme.primary, theme.colorScheme.secondary, 0.7)!,
    ];

    final effectiveLabelStyle = theme.textTheme.labelLarge
        ?.copyWith(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        )
        .merge(labelStyle);

    final defaultLoadingWidget = SizedBox(
      width: loadingSize,
      height: loadingSize,
      child: CircularProgressIndicator(
        color: loadingColor ?? Colors.white,
        strokeWidth: loadingStrokeWidth,
      ),
    );

    final defaultShadow = [
      BoxShadow(
        color: (gradientColors ?? defaultGradient).first.withOpacity(0.3),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ];

    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedOpacity(
            duration: animationDuration ?? const Duration(milliseconds: 200),
            opacity: disabled ? 0.6 : 1.0,
            child: Material(
              elevation: elevation ?? 0,
              borderRadius:
                  customBorderRadius ?? BorderRadius.circular(borderRadius),
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  gradient: customGradient ??
                      LinearGradient(
                        colors: (gradientColors ?? defaultGradient)
                            .map((color) =>
                                color.withOpacity(backgroundBlendOpacity))
                            .toList(),
                        begin: gradientBegin,
                        end: gradientEnd,
                      ),
                  borderRadius:
                      customBorderRadius ?? BorderRadius.circular(borderRadius),
                  boxShadow: showShadowOnlyOnHover
                      ? (isHovered ? (boxShadow ?? defaultShadow) : null)
                      : (boxShadow ?? defaultShadow),
                  border: border,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: (disabled || isLoading) ? null : onPressed,
                    onLongPress: (disabled || isLoading) ? null : onLongPress,
                    borderRadius: customBorderRadius ??
                        BorderRadius.circular(borderRadius),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (states) => overlayColor,
                    ),
                    child: AnimatedContainer(
                      duration: animationDuration ??
                          const Duration(milliseconds: 200),
                      padding: padding,
                      child: customChild ??
                          Row(
                            mainAxisSize: width != null
                                ? MainAxisSize.max
                                : MainAxisSize.min,
                            mainAxisAlignment: mainAxisAlignment,
                            children: [
                              if (isLoading)
                                loadingWidget ?? defaultLoadingWidget
                              else ...[
                                if (prefixIcon != null) ...[
                                  Icon(
                                    prefixIcon,
                                    color: effectiveLabelStyle?.color ??
                                        Colors.white,
                                    size: iconSize,
                                  ),
                                  SizedBox(width: iconSpacing),
                                ],
                                Flexible(
                                  child: Text(
                                    label,
                                    style: effectiveLabelStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (suffixIcon != null) ...[
                                  SizedBox(width: iconSpacing),
                                  Icon(
                                    suffixIcon,
                                    color: effectiveLabelStyle?.color ??
                                        Colors.white,
                                    size: iconSize,
                                  ),
                                ],
                              ],
                            ],
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Factory constructor for creating a filled version without gradient
  factory GradientButton.filled({
    required String label,
    required VoidCallback onPressed,
    Color? backgroundColor,
    IconData? prefixIcon,
    IconData? suffixIcon,
    double? width,
    double height = 50,
    bool isLoading = false,
    bool disabled = false,
    TextStyle? labelStyle,
  }) {
    final color = backgroundColor ?? Colors.blue;
    return GradientButton(
      label: label,
      onPressed: onPressed,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      width: width,
      height: height,
      gradientColors: [color, color],
      isLoading: isLoading,
      disabled: disabled,
      labelStyle: labelStyle,
    );
  }

  /// Factory constructor for creating an outlined version
  factory GradientButton.outlined({
    required String label,
    required VoidCallback onPressed,
    List<Color>? gradientColors,
    IconData? prefixIcon,
    IconData? suffixIcon,
    double? width,
    double height = 50,
    bool isLoading = false,
    bool disabled = false,
    TextStyle? labelStyle,
    double borderWidth = 2,
  }) {
    return GradientButton(
      label: label,
      onPressed: onPressed,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      width: width,
      height: height,
      gradientColors: gradientColors,
      isLoading: isLoading,
      disabled: disabled,
      labelStyle: labelStyle,
      backgroundBlendOpacity: 0,
      border: Border.all(
        color: gradientColors?.first ?? Colors.blue,
        width: borderWidth,
      ),
      boxShadow: [],
    );
  }
}
