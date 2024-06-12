import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_page_model.dart';

final Uri _linkedIn =
    Uri.parse('https://www.linkedin.com/in/jake-palanca-549b462b');
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
  late Animation<double> _scaleAnimation;

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

    _moveAnimation =
        Tween<Offset>(begin: Offset(0.0, 100.0), end: Offset(0.0, 0.0))
            .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
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
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(64),
                            child: Image.asset(
                              'assets/images/avatar.png',
                              width: 75,
                              height: 75,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Jake Palanca',
                            style: GoogleFonts.raleway(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Software Developer',
                          style: GoogleFonts.poppins(
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _launchLinkedIn(),
                            icon: const FaIcon(FontAwesomeIcons.linkedin,
                                size: 14),
                            label: Text('LinkedIn',
                                style: GoogleFonts.poppins(fontSize: 12)),
                            style: ElevatedButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _launchGithub(),
                            icon:
                                const FaIcon(FontAwesomeIcons.github, size: 14),
                            label: Text('Github',
                                style: GoogleFonts.poppins(fontSize: 12)),
                            style: ElevatedButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        )
            .fadeTransition(_fadeAnimation)
            .moveTransition(_moveAnimation)
            .scaleTransition(_scaleAnimation),
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

  Widget scaleTransition(Animation<double> animation) {
    return ScaleTransition(scale: animation, child: this);
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
