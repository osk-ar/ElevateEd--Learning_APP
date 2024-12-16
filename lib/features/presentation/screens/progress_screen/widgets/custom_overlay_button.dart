import 'package:flutter/material.dart';

class CustomButtonWithOverlay extends StatefulWidget {
  final String buttonText;
  final IconData buttonIcon;
  final List<String> options;
  final Function(String) onOptionSelected;
  final Color backgroundColor;
  final double borderRadius;

  const CustomButtonWithOverlay({
    super.key,
    required this.buttonText,
    required this.buttonIcon,
    required this.options,
    required this.onOptionSelected,
    this.backgroundColor = Colors.white,
    this.borderRadius = 8.0,
  });

  @override
  _CustomButtonWithOverlayState createState() =>
      _CustomButtonWithOverlayState();
}

class _CustomButtonWithOverlayState extends State<CustomButtonWithOverlay> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _toggleOverlay() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        left: offset.dx,
        top: offset.dy + 100, // Adjusts the dialog above the button
        child: CompositedTransformFollower(
          link: _layerLink,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Notch triangle
              CustomPaint(
                painter: TrianglePainter(color: widget.backgroundColor),
                child: const SizedBox(
                  height: 10,
                  width: 20,
                ),
              ),
              // Main dialog box
              Material(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                elevation: 4.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: widget.options.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(widget.options[index]),
                        onTap: () {
                          widget.onOptionSelected(widget.options[index]);
                          _toggleOverlay(); // Close the overlay
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: ElevatedButton.icon(
        onPressed: _toggleOverlay,
        icon: Icon(widget.buttonIcon),
        label: Text(widget.buttonText),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;

    final Path path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
