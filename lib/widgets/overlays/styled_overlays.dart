import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StyledDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final List<DialogAction>? actions;
  final Widget? content;
  final IconData? icon;
  final Color? iconColor;
  final bool showCloseButton;

  const StyledDialog({
    super.key,
    this.title,
    this.message,
    this.actions,
    this.content,
    this.icon,
    this.iconColor,
    this.showCloseButton = true,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    String? message,
    List<DialogAction>? actions,
    Widget? content,
    IconData? icon,
    Color? iconColor,
    bool showCloseButton = true,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return StyledDialog(
          title: title,
          message: message,
          actions: actions,
          content: content,
          icon: icon,
          iconColor: iconColor,
          showCloseButton: showCloseButton,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          ),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: theme.dialogBackgroundColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.1),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Content Section
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (showCloseButton)
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(FontAwesomeIcons.xmark, size: 18),
                            onPressed: () => Navigator.pop(context),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ),
                      if (icon != null) ...[
                        SizedBox(height: showCloseButton ? 8 : 0),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: (iconColor ?? theme.colorScheme.primary)
                                .withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            icon,
                            color: iconColor ?? theme.colorScheme.primary,
                            size: 28,
                          ),
                        ),
                      ],
                      if (title != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          title!,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                      if (message != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          message!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodySmall?.color,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                      if (content != null) ...[
                        const SizedBox(height: 16),
                        content!,
                      ],
                    ],
                  ),
                ),
                // Actions Section
                if (actions != null && actions!.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      border: Border(
                        top: BorderSide(
                          color: theme.colorScheme.outline.withOpacity(0.1),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: actions!.length == 1
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.end,
                      children: [
                        for (int i = 0; i < actions!.length; i++) ...[
                          Expanded(
                            child: actions![i],
                          ),
                          if (i < actions!.length - 1) const SizedBox(width: 8),
                        ],
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DialogAction extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isDestructive;
  final IconData? icon;

  const DialogAction({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = false,
    this.isDestructive = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color getButtonColor() {
      if (isDestructive) return theme.colorScheme.error;
      if (isPrimary) return theme.colorScheme.primary;
      return Colors.transparent;
    }

    Color getTextColor() {
      if (isDestructive) {
        return isPrimary ? Colors.white : theme.colorScheme.error;
      }
      if (isPrimary) {
        return theme.colorScheme.onPrimary;
      }
      return theme.colorScheme.primary;
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? getButtonColor() : null,
        foregroundColor: getTextColor(),
        elevation: isPrimary ? 0 : 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: !isPrimary
              ? BorderSide(
                  color: getButtonColor(),
                  width: 1,
                )
              : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: getTextColor(),
            ),
          ),
        ],
      ),
    );
  }
}

class StyledBottomSheet extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? content;
  final List<Widget>? actions;
  final bool showDragHandle;

  const StyledBottomSheet({
    super.key,
    this.title,
    this.message,
    this.content,
    this.actions,
    this.showDragHandle = true,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    String? message,
    Widget? content,
    List<Widget>? actions,
    bool showDragHandle = true,
    bool isDismissible = true,
    Color? backgroundColor,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: isDismissible,
      builder: (context) => StyledBottomSheet(
        title: title,
        message: message,
        content: content,
        actions: actions,
        showDragHandle: showDragHandle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return Container(
      margin: EdgeInsets.only(
        bottom: mediaQuery.viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showDragHandle)
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outline.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (message != null) const SizedBox(height: 8),
                ],
                if (message != null)
                  Text(
                    message!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodySmall?.color,
                    ),
                  ),
                if (content != null) ...[
                  const SizedBox(height: 16),
                  content!,
                ],
              ],
            ),
          ),
          if (actions != null && actions!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                children: [
                  for (int i = 0; i < actions!.length; i++) ...[
                    actions![i],
                    if (i < actions!.length - 1) const SizedBox(height: 8),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class LoadingOverlay extends StatelessWidget {
  final String? message;
  final Widget? customIndicator;

  const LoadingOverlay({
    super.key,
    this.message,
    this.customIndicator,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    String? message,
    Widget? customIndicator,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingOverlay(
        message: message,
        customIndicator: customIndicator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.dialogBackgroundColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            customIndicator ??
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.primary,
                  ),
                ),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ToastOverlay extends StatelessWidget {
  final String message;
  final IconData? icon;
  final Color? backgroundColor;
  final Duration duration;
  final VoidCallback? onDismiss;

  const ToastOverlay({
    super.key,
    required this.message,
    this.icon,
    this.backgroundColor,
    this.duration = const Duration(seconds: 2),
    this.onDismiss,
  });

  static void show({
    required BuildContext context,
    required String message,
    IconData? icon,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 2),
    VoidCallback? onDismiss,
  }) {
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => ToastOverlay(
        message: message,
        icon: icon,
        backgroundColor: backgroundColor,
        duration: duration,
        onDismiss: () {
          overlayEntry.remove();
          onDismiss?.call();
        },
      ),
    );

    Overlay.of(context).insert(overlayEntry);
    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
        onDismiss?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBackgroundColor =
        backgroundColor ?? theme.colorScheme.primary;

    return SafeArea(
      child: DefaultTextStyle(
        style: theme.textTheme.bodyMedium!,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: effectiveBackgroundColor,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: effectiveBackgroundColor.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(
                        icon,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      message,
                    ),
                    // Continuing from ToastOverlay's build method...
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

class ActionSheet extends StatelessWidget {
  final List<ActionSheetItem> actions;
  final String? cancelLabel;

  const ActionSheet({
    super.key,
    required this.actions,
    this.cancelLabel,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required List<ActionSheetItem> actions,
    String? cancelLabel,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ActionSheet(
        actions: actions,
        cancelLabel: cancelLabel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.outline.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ...actions.map((action) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _ActionSheetButton(
                    label: action.label,
                    icon: action.icon,
                    onPressed: () {
                      Navigator.pop(context);
                      action.onPressed();
                    },
                    isDestructive: action.isDestructive,
                  ),
                )),
            if (cancelLabel != null)
              _ActionSheetButton(
                label: cancelLabel!,
                onPressed: () => Navigator.pop(context),
                isCancel: true,
              ),
          ],
        ),
      ),
    );
  }
}

class ActionSheetItem {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isDestructive;

  const ActionSheetItem({
    required this.label,
    this.icon,
    required this.onPressed,
    this.isDestructive = false,
  });
}

class _ActionSheetButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isDestructive;
  final bool isCancel;

  const _ActionSheetButton({
    required this.label,
    this.icon,
    required this.onPressed,
    this.isDestructive = false,
    this.isCancel = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color getTextColor() {
      if (isDestructive) return theme.colorScheme.error;
      if (isCancel) return theme.colorScheme.primary;
      return theme.colorScheme.onSurface;
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isCancel ? Colors.transparent : theme.colorScheme.surface,
          foregroundColor: getTextColor(),
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isCancel
                ? BorderSide(
                    color: theme.colorScheme.outline.withOpacity(0.2),
                  )
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: getTextColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopoverMenu extends StatelessWidget {
  final List<PopoverMenuItem> items;
  final Widget child;
  final Color? backgroundColor;
  final double maxWidth;
  final EdgeInsets padding;
  final GlobalKey buttonKey = GlobalKey();

  PopoverMenu({
    super.key,
    required this.items,
    required this.child,
    this.backgroundColor,
    this.maxWidth = 280,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
  });

  void _showPopover(BuildContext context) {
    final theme = Theme.of(context);
    final RenderBox button =
        buttonKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final buttonPosition = button.localToGlobal(Offset.zero, ancestor: overlay);
    final buttonSize = button.size;
    final screenSize = MediaQuery.of(context).size;

    // Calculate position
    var left = buttonPosition.dx;
    if (left + maxWidth > screenSize.width) {
      left = screenSize.width - maxWidth - 8;
    }

    var top = buttonPosition.dy + buttonSize.height + 8;
    final isBottom =
        (top + 200) > screenSize.height; // 200 is estimated popover height
    if (isBottom) {
      top = buttonPosition.dy - 8 - 200; // Show above the button
    }

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            left: left,
            top: top,
            child: Material(
              color: Colors.transparent,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: maxWidth,
                  maxHeight: 300,
                ),
                decoration: BoxDecoration(
                  color: backgroundColor ?? theme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: padding,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: items
                          .map((item) => _PopoverMenuItemWidget(
                                item: item,
                                onTap: () {
                                  Navigator.pop(context);
                                  item.onTap();
                                },
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: buttonKey,
      onTap: () => _showPopover(context),
      child: child,
    );
  }
}

class _PopoverMenuItemWidget extends StatefulWidget {
  final PopoverMenuItem item;
  final VoidCallback onTap;

  const _PopoverMenuItemWidget({
    required this.item,
    required this.onTap,
  });

  @override
  State<_PopoverMenuItemWidget> createState() => _PopoverMenuItemWidgetState();
}

class _PopoverMenuItemWidgetState extends State<_PopoverMenuItemWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: widget.onTap,
      onHover: (value) => setState(() => _isHovered = value),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: _isHovered
              ? theme.colorScheme.primary.withOpacity(0.1)
              : Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.item.icon != null) ...[
              Icon(
                widget.item.icon,
                size: 18,
                color: widget.item.isDestructive
                    ? theme.colorScheme.error
                    : theme.colorScheme.onSurface,
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                widget.item.label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: widget.item.isDestructive
                      ? theme.colorScheme.error
                      : theme.colorScheme.onSurface,
                ),
              ),
            ),
            if (widget.item.trailing != null) ...[
              const SizedBox(width: 12),
              widget.item.trailing!,
            ],
          ],
        ),
      ),
    );
  }
}

class PopoverMenuItem {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;
  final bool isDestructive;
  final Widget? trailing;

  const PopoverMenuItem({
    required this.label,
    this.icon,
    required this.onTap,
    this.isDestructive = false,
    this.trailing,
  });
}
