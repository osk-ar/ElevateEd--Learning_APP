import 'dart:math' as math;

import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class DraggableFab extends StatefulWidget {
  final double topPadding;
  final double bottomPadding;
  final double leftPadding;
  final double rightPadding;
  final double fabSize;
  final List<FabItemData> childFabs;
  final Color mainFabColor;
  final IconData mainFabIcon;
  final IconData mainFabCloseIcon;
  final VoidCallback? onMainFabTap;
  final double childFabSpacing;

  final double screenWidth;
  final double screenHeight;

  const DraggableFab({
    super.key,
    this.topPadding = 60,
    this.bottomPadding = 140,
    this.leftPadding = 20,
    this.rightPadding = 80,
    this.fabSize = 56,
    this.childFabs = const [],
    this.mainFabColor = AppColors.primaryColor,
    this.mainFabIcon = Icons.add,
    this.mainFabCloseIcon = Icons.close,
    this.onMainFabTap,
    this.childFabSpacing = 8,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  State<DraggableFab> createState() => _DraggableFabState();
}

class _DraggableFabState extends State<DraggableFab>
    with SingleTickerProviderStateMixin {
  bool _isFabExpanded = false;
  late AnimationController _animationController;
  Animation<Offset>? animation;
  Offset _dragPosition = Offset.zero;
  Offset _targetPosition = Offset.zero;

  // Snap threshold - how close to corner to trigger snap
  final double snapThreshold = 60.0;
  final bool isDragging = false;
  ScreenCorner currentCorner = ScreenCorner.bottomRight;

  late final double rightCalcedPadding;
  late final double bottomCalcedPadding;

  @override
  void initState() {
    super.initState();
    if (widget.childFabs.isEmpty) {
      assert(
        widget.onMainFabTap != null,
        'Main FAB must have a callback if child FABs are not provided',
      );
    }

    rightCalcedPadding = widget.rightPadding + widget.fabSize;
    bottomCalcedPadding = widget.bottomPadding + widget.fabSize;

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Start at bottom right
    _targetPosition = Offset(widget.screenWidth - rightCalcedPadding,
        widget.screenHeight - bottomCalcedPadding);
    _dragPosition = _targetPosition;
  }

  void _toggleFab() {
    if (widget.childFabs.isNotEmpty) {
      setState(() {
        _isFabExpanded = !_isFabExpanded;
      });
    }

    // Call the custom callback if provided
    if (widget.onMainFabTap != null) {
      widget.onMainFabTap!();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _simulateDragWithPhysics(Offset velocity) {
    _animationController.stop();

    // Find nearest corner for snap target
    _findNearestCorner();

    // Define the spring simulation
    const SpringDescription spring = SpringDescription(
      mass: 1.0,
      stiffness: 300.0,
      damping: 20.0,
    );

    final simulation = SpringSimulation(
      spring,
      0.0,
      1.0,
      -velocity.distance / 1500,
      // Convert velocity to simulation friendly value
    );

    // Store start point for interpolation
    final Offset startPoint = _dragPosition;

    animation = _animationController.drive(
      Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(1.0, 1.0),
      ).chain(
        CurveTween(curve: Curves.easeOutCirc),
      ),
    );

    // Update position during animation
    _animationController.addListener(() {
      final double animValue = _animationController.value;
      setState(() {
        _dragPosition = Offset.lerp(startPoint, _targetPosition, animValue)!;
      });
    });

    // Start the animation
    _animationController.animateWith(simulation);
  }

  void _findNearestCorner() {
    // Calculate distances to each corner
    final List<_CornerData> corners = [
      _CornerData(
          corner: ScreenCorner.topLeft,
          position: Offset(widget.leftPadding, widget.topPadding),
          distance:
              (_dragPosition - Offset(widget.leftPadding, widget.topPadding))
                  .distance),
      _CornerData(
          corner: ScreenCorner.topRight,
          position: Offset(
              widget.screenWidth - rightCalcedPadding, widget.topPadding),
          distance: (_dragPosition -
                  Offset(widget.screenWidth - rightCalcedPadding,
                      widget.topPadding))
              .distance),
      _CornerData(
          corner: ScreenCorner.bottomLeft,
          position: Offset(
              widget.leftPadding, widget.screenHeight - bottomCalcedPadding),
          distance: (_dragPosition -
                  Offset(widget.leftPadding,
                      widget.screenHeight - bottomCalcedPadding))
              .distance),
      _CornerData(
          corner: ScreenCorner.bottomRight,
          position: Offset(widget.screenWidth - rightCalcedPadding,
              widget.screenHeight - bottomCalcedPadding),
          distance: (_dragPosition -
                  Offset(widget.screenWidth - rightCalcedPadding,
                      widget.screenHeight - bottomCalcedPadding))
              .distance),
    ];

    // Find the closest corner
    corners.sort((a, b) => a.distance.compareTo(b.distance));
    currentCorner = corners.first.corner;
    _targetPosition = corners.first.position;
  }

  @override
  Widget build(BuildContext context) {
    // Determine if the FAB is positioned near top or bottom
    bool isNearTop = currentCorner == ScreenCorner.topLeft ||
        currentCorner == ScreenCorner.topRight;
    return Positioned(
      left: _dragPosition.dx,
      top: isNearTop ? _dragPosition.dy : null,
      bottom: !isNearTop
          ? widget.screenHeight - _dragPosition.dy - widget.fabSize
          : null,
      child: GestureDetector(
        onPanStart: (details) {
          // Stop any ongoing animation when starting a new drag
          _animationController.stop();

          // Close the menu when dragging starts
          if (_isFabExpanded) {
            setState(
              () {
                _isFabExpanded = false;
              },
            );
          }
        },
        onPanUpdate: (details) {
          setState(() {
            _dragPosition += details.delta;

            // Keep FAB within screen bounds
            _dragPosition = Offset(
                math.max(
                    widget.leftPadding,
                    math.min(
                        widget.screenWidth -
                            rightCalcedPadding +
                            widget.fabSize / 2,
                        _dragPosition.dx)),
                math.max(
                    widget.topPadding,
                    math.min(
                        widget.screenHeight -
                            bottomCalcedPadding +
                            widget.fabSize / 2,
                        _dragPosition.dy)));
          });
        },
        onPanEnd: (details) {
          // Apply physics-based animation to final position
          _simulateDragWithPhysics(details.velocity.pixelsPerSecond);
        },
        child: RepaintBoundary(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...getChildFabs(show: !isNearTop, isAboveMain: true),

              // Main FAB
              FloatingActionButton(
                backgroundColor: widget.mainFabColor,
                onPressed: isDragging ? null : _toggleFab,
                child: Icon(
                  _isFabExpanded ? widget.mainFabCloseIcon : widget.mainFabIcon,
                  color: AppColors.whiteColor,
                ),
              ),

              ...getChildFabs(show: isNearTop, isAboveMain: false),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getChildFabs({
    required bool show,
    required bool isAboveMain,
  }) {
    List<Widget> widgets = List.generate(
      growable: false,
      widget.childFabs.length,
      (index) => AnimatedSizeAndFade(
        sizeDuration: const Duration(milliseconds: 200),
        fadeDuration: const Duration(milliseconds: 150),
        show: _isFabExpanded && !isDragging && show,
        child: Padding(
          padding: EdgeInsets.only(
            top: !isAboveMain ? widget.childFabSpacing : 0,
            bottom: isAboveMain ? widget.childFabSpacing : 0,
          ),
          child: FloatingActionButton(
            heroTag: "fab$index",
            backgroundColor:
                widget.childFabs[index].backgroundColor ?? widget.mainFabColor,
            mini: true,
            onPressed: () {
              _toggleFab();
              widget.childFabs[index].onPressed.call();
            },
            child: Icon(
              widget.childFabs[index].icon,
              color: widget.childFabs[index].iconColor ?? AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );

    return isAboveMain ? widgets : widgets.reversed.toList();
  }
}

// Model class for child FAB items
class FabItemData {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? iconColor;

  const FabItemData({
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
  });
}

// Add this helper widget for smooth animations
class AnimatedSizeAndFade extends StatelessWidget {
  final Widget child;
  final Duration sizeDuration;
  final Duration fadeDuration;
  final bool show;

  const AnimatedSizeAndFade({
    required this.child,
    required this.sizeDuration,
    required this.fadeDuration,
    required this.show,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: sizeDuration,
      child: AnimatedOpacity(
        opacity: show ? 1.0 : 0.0,
        duration: fadeDuration,
        child: show ? child : const SizedBox.shrink(),
      ),
    );
  }
}

// Helper enum for tracking corner positions
enum ScreenCorner { topLeft, topRight, bottomLeft, bottomRight }

// Add this class to help with corner calculations
class _CornerData {
  final ScreenCorner corner;
  final Offset position;
  final double distance;

  _CornerData({
    required this.corner,
    required this.position,
    required this.distance,
  });
}
