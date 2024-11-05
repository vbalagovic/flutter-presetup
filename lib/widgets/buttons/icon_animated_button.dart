import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class IconAnimatedButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? color;

  const IconAnimatedButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.color,
  });

  @override
  State<IconAnimatedButton> createState() => _IconAnimatedButtonState();
}

class _IconAnimatedButtonState extends State<IconAnimatedButton> {
  bool _isActive = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isActive = true);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isActive = false);
    widget.onPressed();
  }

  void _handleTapCancel() {
    setState(() => _isActive = false);
  }

  void _handleHover(bool isHovered) {
    if (kIsWeb) {
      setState(() => _isActive = isHovered);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor = widget.color ?? theme.colorScheme.primary;

    return MouseRegion(
      onEnter: kIsWeb ? (_) => _handleHover(true) : null,
      onExit: kIsWeb ? (_) => _handleHover(false) : null,
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: _isActive ? buttonColor : buttonColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: buttonColor.withOpacity(_isActive ? 0 : 0.2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: _isActive ? Colors.white : buttonColor,
                size: 18,
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _isActive ? 8 : 0,
              ),
              if (_isActive)
                Text(
                  widget.label,
                  style: TextStyle(
                    color: _isActive ? Colors.white : buttonColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
