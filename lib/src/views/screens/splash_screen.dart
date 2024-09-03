import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          "assets/splash_logo.png",
                          width: 250,
                        ),
                      ),
                      const SizedBox(height: 28),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.sizeOf(context).width * 0.5,
                        ),
                        child: const ShadProgress(
                          minHeight: 3,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Text('Initializing...',
                          style: ShadTheme.of(context).textTheme.h3),
                    ],
                  ),
                ),
              ),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Welcome to the ',
                    style: ShadTheme.of(context).textTheme.h1Large,
                    children: [
                      TextSpan(
                        text: 'QallR ',
                        style: ShadTheme.of(context).textTheme.h1Large.copyWith(
                              color: Colors.blueAccent,
                            ),
                      ),
                      TextSpan(
                        text: 'App',
                        style: ShadTheme.of(context).textTheme.h1Large,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
