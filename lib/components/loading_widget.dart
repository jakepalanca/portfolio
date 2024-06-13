import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Color backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();
    // Delay the color change to allow for the transition
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        backgroundColor = Theme.of(context).scaffoldBackgroundColor;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 2),
        color: backgroundColor,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
