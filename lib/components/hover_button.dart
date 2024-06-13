import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HoverButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const HoverButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  HoverButtonState createState() => HoverButtonState();
}

class HoverButtonState extends State<HoverButton>
    with SingleTickerProviderStateMixin {
  bool _isHovering = false;
  bool _isPressed = false;

  late AnimationController _controller;
  late Animation<double> _borderAnimation;
  late Animation<Color?> _backgroundColorAnimation;
  late Animation<double> _iconSizeAnimation;
  late Animation<double> _textSizeAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    final fastCurve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _borderAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(fastCurve);
    _backgroundColorAnimation = ColorTween(
      begin: Colors.grey[300],
      end: Colors.grey[200],
    ).animate(fastCurve);
    _iconSizeAnimation =
        Tween<double>(begin: 14.0, end: 16.0).animate(fastCurve);
    _textSizeAnimation =
        Tween<double>(begin: 12.0, end: 14.0).animate(fastCurve);
    _colorAnimation =
        ColorTween(begin: Colors.grey[800], end: Color(0xFFFF7A9A))
            .animate(fastCurve);
  }

  void _handleHover(bool hovering) {
    setState(() {
      _isHovering = hovering;
      if (hovering || _isPressed) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
    _handleHover(true);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    _handleHover(false);
    widget.onPressed();
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
    _handleHover(false);
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final darkBackgroundColor = Colors.grey[800];
    final lightBackgroundColor = Colors.grey[300];
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    final buttonBackgroundColor =
        isDarkMode ? darkBackgroundColor : lightBackgroundColor;
    final iconTextColor = isDarkMode ? Colors.white : Colors.black;

    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MouseRegion(
            onEnter: (_) => _handleHover(true),
            onExit: (_) => _handleHover(false),
            child: GestureDetector(
              onTapDown: _handleTapDown,
              onTapUp: _handleTapUp,
              onTapCancel: _handleTapCancel,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Container(
                    margin:
                        const EdgeInsets.all(0), // No margin change on hover
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _isHovering || _isPressed
                            ? primaryColor
                            : Colors.transparent,
                        width: _borderAnimation.value,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: _isHovering || _isPressed
                          ? primaryColor.withOpacity(
                              0.1) // Slightly tinted on hover/press
                          : buttonBackgroundColor,
                    ),
                    child: TextButton.icon(
                      onPressed: widget.onPressed,
                      icon: FaIcon(
                        widget.icon,
                        size: _iconSizeAnimation.value,
                        color: _isHovering || _isPressed
                            ? primaryColor
                            : iconTextColor,
                      ),
                      label: AnimatedBuilder(
                        animation: _textSizeAnimation,
                        builder: (context, child) {
                          return Text(
                            widget.label,
                            style: GoogleFonts.poppins(
                              fontSize: _textSizeAnimation.value,
                              color: _isHovering || _isPressed
                                  ? primaryColor
                                  : iconTextColor,
                            ),
                          );
                        },
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: buttonBackgroundColor,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        shadowColor: Colors.transparent,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
