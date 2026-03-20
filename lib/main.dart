import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/under_construction_page.dart';
import 'pages/privacy_policy_page.dart';

void main() {
  runApp(const FallKeyApp());
}

class FallKeyApp extends StatelessWidget {
  const FallKeyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // GoRouter configuration with Hash Routing (default for web)
    final GoRouter router = GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const UnderConstructionPage();
          },
        ),
        GoRoute(
          path: '/sports-merge/privacy',
          builder: (BuildContext context, GoRouterState state) {
            return const PrivacyPolicyPage();
          },
        ),
      ],
    );

    return MaterialApp.router(
      title: 'FallKey',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0b0c10),
        textTheme: GoogleFonts.outfitTextTheme(Theme.of(context).textTheme).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
