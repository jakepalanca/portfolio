import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HoverButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const HoverButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  HoverButtonState createState() => HoverButtonState();
}

class HoverButtonState extends State<HoverButton>
    with SingleTickerProviderStateMixin {
  bool _isHovering = false;

  late AnimationController _controller;
  late Animation<double> _borderAnimation;
  late Animation<double> _backgroundColorAnimation;
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
    _backgroundColorAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(fastCurve);
    _iconSizeAnimation = Tween<double>(begin: 14.0, end: 16.0)
        .animate(fastCurve); // 2 units increase
    _textSizeAnimation = Tween<double>(begin: 12.0, end: 14.0)
        .animate(fastCurve); // 2 units increase
    _colorAnimation =
        ColorTween(begin: Colors.grey[800], end: Color(0xFFFF7A9A))
            .animate(fastCurve);
  }

  void _handleHover(bool hovering) {
    setState(() {
      _isHovering = hovering;
      if (hovering) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _handleTap() {
    setState(() {
      _isHovering = true;
    });
    _controller.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _isHovering = false;
          });
          _controller.reverse();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MouseRegion(
            onEnter: (_) => _handleHover(true),
            onExit: (_) => _handleHover(false),
            child: GestureDetector(
              onTap: () {
                _handleTap();
                widget.onPressed();
              },
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Container(
                    margin: EdgeInsets.all(
                        _isHovering ? 4 : 0), // Margin change on hover
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _isHovering ? primaryColor : Colors.transparent,
                        width: _borderAnimation.value,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.lerp(Colors.grey[300], backgroundColor,
                            _backgroundColorAnimation.value),
                        borderRadius: BorderRadius.circular(
                            12), // Ensure same radius as outer container
                      ),
                      child: TextButton.icon(
                        onPressed: widget.onPressed,
                        icon: FaIcon(
                          widget.icon,
                          size: _iconSizeAnimation.value,
                          color: _colorAnimation.value,
                        ),
                        label: AnimatedBuilder(
                          animation: _textSizeAnimation,
                          builder: (context, child) {
                            return Text(
                              widget.label,
                              style: GoogleFonts.poppins(
                                fontSize: _textSizeAnimation.value,
                                color: _colorAnimation.value,
                              ),
                            );
                          },
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: backgroundColor,
                          backgroundColor: Colors
                              .transparent, // Transparent to show custom background
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // Ensure same radius
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          shadowColor:
                              Colors.transparent, // Ensure no shadow is applied
                        ),
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
