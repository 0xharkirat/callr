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
                        ).animate().fadeIn(
                              begin: 0,
                              curve: Curves.easeInOut,
                              duration: 0.5.seconds,
                            ),
                      ),
                      const SizedBox(height: 28),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.sizeOf(context).width * 0.5,
                        ),
                        child: const ShadProgress(
                          minHeight: 3,
                        ).animate().fadeIn(
                              delay: 200.ms,
                              begin: 0,
                              curve: Curves.easeInOut,
                              duration: 0.5.seconds,
                            ),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'Initializing...',
                        style: ShadTheme.of(context).textTheme.h3,
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(
                            delay: 400.ms,
                            begin: 0,
                            curve: Curves.easeInOut,
                            duration: 0.5.seconds,
                          ),
                    ],
                  ),
                ),
              ),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Text(
                          "Welcome to the ",
                          style: ShadTheme.of(context).textTheme.h1Large,
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(
                              begin: 0,
                              curve: Curves.easeInOut,
                              duration: 0.5.seconds,
                            ),
                      ),
                      WidgetSpan(
                        child: Text(
                          'Q',
                          style:
                              ShadTheme.of(context).textTheme.h1Large.copyWith(
                                    color: Colors.blueAccent,
                                  ),
                        ).animate().slideX(
                              delay: 100.ms,
                              begin: 0.9,
                              curve: Curves.easeInOut,
                              duration: 1.seconds,
                            ),
                      ),
                      WidgetSpan(
                        child: Text(
                          'all',
                          style:
                              ShadTheme.of(context).textTheme.h1Large.copyWith(
                                    color: Colors.blueAccent,
                                  ),
                        ).animate().fadeIn(
                              delay: 1.1.seconds,
                              begin: 0,
                              curve: Curves.easeInOut,
                              duration: 0.5.seconds,
                            ),
                      ),
                      WidgetSpan(
                        child: Text(
                          'R ',
                          style:
                              ShadTheme.of(context).textTheme.h1Large.copyWith(
                                    color: Colors.blueAccent,
                                  ),
                        ).animate().slideX(
                              delay: 100.ms,
                              begin: -0.9,
                              curve: Curves.easeInOut,
                              duration: 1.seconds,
                            ),
                      ),
                      WidgetSpan(
                        child: Text(
                          'App',
                          style: ShadTheme.of(context).textTheme.h1Large,
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(
                              begin: 0,
                              curve: Curves.easeInOut,
                              duration: 0.5.seconds,
                            ),
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
