import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/under_construction_page.dart';
import 'pages/privacy_policy_page.dart';
import 'pages/sports_merge_support_page.dart';
import 'pages/sports_merge/sports_merge_page.dart';

void main() {
  usePathUrlStrategy();
  runApp(const FallKeyApp());
}

class FallKeyApp extends StatelessWidget {
  const FallKeyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // GoRouter configuration with Path URL Strategy
    final GoRouter router = GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const UnderConstructionPage();
          },
        ),
        GoRoute(
          path: '/sports-merge',
          name: 'sports-merge',
          builder: (BuildContext context, GoRouterState state) {
            final lang = state.uri.queryParameters['lang'];
            return SportsMergePage(initialLang: lang);
          },
        ),
        GoRoute(
          path: '/sports-merge/privacy',
          builder: (BuildContext context, GoRouterState state) {
            return const PrivacyPolicyPage();
          },
        ),
        GoRoute(
          path: '/sports-merge/support',
          builder: (BuildContext context, GoRouterState state) {
            final lang = state.uri.queryParameters['lang'];
            return SportsMergeSupportPage(initialLang: lang);
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
