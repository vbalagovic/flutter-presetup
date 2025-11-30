
import 'package:flutter/material.dart';

class SwipeableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final Widget? leftAction;
  final Widget? rightAction;

  const SwipeableCard({
    super.key,
    required this.child,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.leftAction,
    this.rightAction,
  });

  @override
  State<SwipeableCard> createState() => _SwipeableCardState();
}

class _SwipeableCardState extends State<SwipeableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late double _dragStartX;
  bool _isSwipingLeft = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDragStart(DragStartDetails details) {
    _dragStartX = details.localPosition.dx;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final delta = details.localPosition.dx - _dragStartX;
    _isSwipingLeft = delta < 0;
    setState(() {
      _animation = Tween<Offset>(
        begin: Offset(delta / context.size!.width, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      );
    });
  }

  void _onDragEnd(DragEndDetails details) {
    final velocity = details.velocity.pixelsPerSecond.dx;
    if (velocity.abs() > 1000) {
      if (velocity < 0 && widget.onSwipeLeft != null) {
        widget.onSwipeLeft!();
      } else if (velocity > 0 && widget.onSwipeRight != null) {
        widget.onSwipeRight!();
      }
    }
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.leftAction != null && _isSwipingLeft)
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: widget.leftAction!,
            ),
          ),
        if (widget.rightAction != null && !_isSwipingLeft)
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: widget.rightAction!,
            ),
          ),
        GestureDetector(
          onHorizontalDragStart: _onDragStart,
          onHorizontalDragUpdate: _onDragUpdate,
          onHorizontalDragEnd: _onDragEnd,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) => SlideTransition(
              position: _animation,
              child: child,
            ),
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
