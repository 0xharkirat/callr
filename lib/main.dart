import 'package:callr/src/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(appRouter);
    return ShadApp.materialRouter(
      title: 'QallR',
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ShadThemeData(
        textTheme: ShadTextTheme.fromGoogleFont(
          GoogleFonts.manrope,
        ),
        brightness: Brightness.dark,
        colorScheme: const ShadSlateColorScheme.dark(),
      ),
    );
  }
}


