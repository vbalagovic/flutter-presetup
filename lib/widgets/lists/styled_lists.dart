import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnimatedListTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final IconData? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? color;

  const AnimatedListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.color,
  });

  @override
  State<AnimatedListTile> createState() => _AnimatedListTileState();
}

class _AnimatedListTileState extends State<AnimatedListTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = widget.color ?? theme.colorScheme.primary;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _isPressed ? color.withOpacity(0.1) : theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                _isPressed ? color : theme.colorScheme.outline.withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            if (widget.leading != null) ...[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(widget.leading, color: color, size: 20),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (widget.subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (widget.trailing != null) ...[
              const SizedBox(width: 12),
              widget.trailing!,
            ],
          ],
        ),
      ),
    );
  }
}

class SwipeActionListTile extends StatefulWidget {
  final Widget child;
  final List<SwipeAction> actions;
  final double actionWidth;
  final Duration animationDuration;

  const SwipeActionListTile({
    super.key,
    required this.child,
    required this.actions,
    this.actionWidth = 80,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  State<SwipeActionListTile> createState() => _SwipeActionListTileState();
}

class _SwipeActionListTileState extends State<SwipeActionListTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late double _dragStartX;
  late double _dragExtent;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1, 0),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDragStart(DragStartDetails details) {
    _dragStartX = details.localPosition.dx;
    _dragExtent = 0;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    final delta = details.localPosition.dx - _dragStartX;
    if (delta < 0) {
      setState(() {
        _dragExtent = delta.abs();
        final value =
            _dragExtent / (widget.actionWidth * widget.actions.length);
        _controller.value = value.clamp(0.0, 1.0);
      });
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.value > 0.5) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: widget.actions.map((action) {
              return Container(
                width: widget.actionWidth,
                color: action.backgroundColor,
                child: Center(
                  child: Icon(
                    action.icon,
                    color: Colors.white,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        GestureDetector(
          onHorizontalDragStart: _handleDragStart,
          onHorizontalDragUpdate: _handleDragUpdate,
          onHorizontalDragEnd: _handleDragEnd,
          child: SlideTransition(
            position: _slideAnimation,
            child: widget.child,
          ),
        ),
      ],
    );
  }
}

class SwipeAction {
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onTap;

  const SwipeAction({
    required this.icon,
    required this.backgroundColor,
    required this.onTap,
  });
}

class GroupedListSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final EdgeInsets? padding;

  const GroupedListSection({
    super.key,
    required this.title,
    required this.children,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: Text(
            title.toUpperCase(),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            border: Border(
              top: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.1),
              ),
              bottom: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.1),
              ),
            ),
          ),
          child: Column(
            children: [
              for (int i = 0; i < children.length; i++) ...[
                children[i],
                if (i < children.length - 1)
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Divider(
                      height: 1,
                      color: theme.colorScheme.outline.withOpacity(0.1),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class ExpandableListTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final IconData? leading;
  final List<Widget> children;
  final bool initiallyExpanded;

  const ExpandableListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    required this.children,
    this.initiallyExpanded = false,
  });

  @override
  State<ExpandableListTile> createState() => _ExpandableListTileState();
}

class _ExpandableListTileState extends State<ExpandableListTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconTurns = _controller.drive(Tween<double>(begin: 0.0, end: 0.5));
    _heightFactor = _controller.drive(Tween<double>(begin: 0.0, end: 1.0));
    _isExpanded =
        PageStorage.of(context).readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      PageStorage.of(context).writeState(context, _isExpanded);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        InkWell(
          onTap: _handleTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (widget.leading != null) ...[
                  Icon(widget.leading, color: theme.colorScheme.primary),
                  const SizedBox(width: 16),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: theme.textTheme.titleMedium,
                      ),
                      if (widget.subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          widget.subtitle!,
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ],
                  ),
                ),
                RotationTransition(
                  turns: _iconTurns,
                  child: const Icon(FontAwesomeIcons.chevronDown, size: 16),
                ),
              ],
            ),
          ),
        ),
        ClipRect(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return SizeTransition(
                sizeFactor: _heightFactor,
                child: child,
              );
            },
            child: Column(
              children: widget.children,
            ),
          ),
        ),
      ],
    );
  }
}

class ReorderableListItem extends StatelessWidget {
  final Widget child;
  final VoidCallback? onReorder;
  final bool isFirst;
  final bool isLast;

  const ReorderableListItem({
    super.key,
    required this.child,
    this.onReorder,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(
        top: isFirst ? 0 : 8,
        bottom: isLast ? 0 : 8,
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Stack(
        children: [
          child,
          if (onReorder != null)
            Positioned(
              right: 8,
              top: 0,
              bottom: 0,
              child: Icon(
                FontAwesomeIcons.gripVertical,
                size: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.3),
              ),
            ),
        ],
      ),
    );
  }
}

class ListItemBadge extends StatelessWidget {
  final String text;
  final Color? color;
  final bool outlined;

  const ListItemBadge({
    super.key,
    required this.text,
    this.color,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badgeColor = color ?? theme.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: outlined ? null : badgeColor.withOpacity(0.1),
        border: outlined ? Border.all(color: badgeColor) : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: theme.textTheme.bodySmall?.copyWith(
          color: badgeColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
