import 'package:flutter/widgets.dart';

class ScaleButton extends StatefulWidget {
  const ScaleButton({super.key, required this.onTap, required this.child});

  @override
  State<ScaleButton> createState() => _ScaleButtonState();
  final VoidCallback? onTap;
  final Widget child;
}

class _ScaleButtonState extends State<ScaleButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isPressed ? .97 : 1,
      duration: const Duration(milliseconds: 100),
      child: GestureDetector(
        onTap: () {
          if (widget.onTap != null) {
            setState(() {
              isPressed = true;
            });
            Future.delayed(const Duration(milliseconds: 50)).then((value) {
              setState(() {
                isPressed = false;
              });
              widget.onTap!();
            });
          }
        },
        onTapDown: (_) {
          if (widget.onTap != null) {
            setState(() {
              isPressed = true;
            });
          }
        },
        onTapUp: (_) {
          if (widget.onTap != null) {
            setState(() {
              isPressed = false;
            });
          }
        },
        onTapCancel: () {
          if (widget.onTap != null) {
            setState(() {
              isPressed = false;
            });
          }
        },
        child: widget.child,
      ),
    );
  }
}
