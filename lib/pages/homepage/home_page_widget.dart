import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jakepalanca/components/hover_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_page_model.dart';

final Uri _linkedIn = Uri.parse('https://www.linkedin.com/in/jakepalanca');
final Uri _github = Uri.parse('https://github.com/jakepalanca');

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _moveAnimation;

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();
    _model.initState(context);

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _moveAnimation = Tween<Offset>(
            begin: const Offset(0.0, 0.2), end: const Offset(0.0, 0.0))
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _model.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: SlideTransition(
            position: _moveAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(64),
                    child: Image.asset(
                      'assets/images/avatar.png',
                      width: 75,
                      height: 75,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: Text(
                      'Jake Palanca',
                      style: GoogleFonts.raleway(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.displayLarge?.color,
                      ),
                    ),
                  ),
                  Text(
                    'Software Developer',
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  HoverButton(
                    icon: FontAwesomeIcons.linkedin,
                    label: 'LinkedIn',
                    onPressed: _launchLinkedIn,
                  ),
                  const SizedBox(height: 8), // Space between buttons
                  HoverButton(
                    icon: FontAwesomeIcons.github,
                    label: 'Github',
                    onPressed: _launchGithub,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension on Widget {
  Widget fadeTransition(Animation<double> animation) {
    return FadeTransition(opacity: animation, child: this);
  }

  Widget moveTransition(Animation<Offset> animation) {
    return SlideTransition(position: animation, child: this);
  }
}

Future<void> _launchLinkedIn() async {
  if (!await launchUrl(_linkedIn)) {
    throw Exception('Could not launch $_linkedIn');
  }
}

Future<void> _launchGithub() async {
  if (!await launchUrl(_github)) {
    throw Exception('Could not launch $_github');
  }
}
