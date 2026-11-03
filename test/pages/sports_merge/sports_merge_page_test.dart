import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fallkey_page/pages/sports_merge/sports_merge_page.dart';
import 'package:fallkey_page/pages/sports_merge/models/sports_merge_content.dart';
import 'package:fallkey_page/pages/sports_merge/widgets/components/store_badge_button.dart';
import 'package:fallkey_page/pages/sports_merge/widgets/sections/sports_merge_hero_section.dart';
import 'package:fallkey_page/pages/sports_merge/widgets/sections/sports_merge_media_section.dart';
import 'package:fallkey_page/pages/sports_merge/widgets/sections/sports_merge_features_section.dart';
import 'package:fallkey_page/pages/sports_merge/widgets/sections/sports_merge_store_badges_section.dart';
import 'package:fallkey_page/pages/sports_merge/widgets/sections/sports_merge_footer_section.dart';

void main() {
  group('SportsMergePage Widget Tests', () {
    testWidgets('T009 [US1]: Renders Hero section, title, and Google Play Store button', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1280, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        const MaterialApp(
          home: SportsMergePage(initialLang: 'pt'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SportsMergeHeroSection), findsOneWidget);
      expect(find.byType(SportsMergeMediaSection), findsOneWidget);
      expect(find.byType(SportsMergeFeaturesSection), findsOneWidget);
      expect(find.byType(SportsMergeStoreBadgesSection), findsOneWidget);
      expect(find.byType(SportsMergeFooterSection), findsOneWidget);

      expect(find.text('Sports Merge'), findsOneWidget);
      expect(find.text(SportsMergeContent.pt.heroTitle), findsOneWidget);
      expect(find.text(SportsMergeContent.pt.playStoreButtonLabel), findsWidgets);
    });

    testWidgets('T015 [US2]: Language toggle switches texts between PT and EN instantaneously', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1280, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        const MaterialApp(
          home: SportsMergePage(initialLang: 'pt'),
        ),
      );
      await tester.pumpAndSettle();

      // Initially Portuguese
      expect(find.text(SportsMergeContent.pt.heroTitle), findsOneWidget);
      expect(find.text(SportsMergeContent.pt.featuresTitle), findsOneWidget);

      // Tap EN option in LanguageSelector
      final enButton = find.text('EN');
      expect(enButton, findsOneWidget);
      await tester.tap(enButton);
      await tester.pumpAndSettle();

      // Now English
      expect(find.text(SportsMergeContent.en.heroTitle), findsOneWidget);
      expect(find.text(SportsMergeContent.en.featuresTitle), findsOneWidget);

      // Tap PT option to switch back
      final ptButton = find.text('PT');
      expect(ptButton, findsOneWidget);
      await tester.tap(ptButton);
      await tester.pumpAndSettle();

      expect(find.text(SportsMergeContent.pt.heroTitle), findsOneWidget);
    });

    testWidgets('T015 [US2]: Initializing with initialLang=en starts in English', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1280, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        const MaterialApp(
          home: SportsMergePage(initialLang: 'en'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(SportsMergeContent.en.heroTitle), findsOneWidget);
      expect(find.text(SportsMergeContent.en.featuresTitle), findsOneWidget);
    });

    testWidgets('T018 [US3]: Layout renders without overflow on mobile (360x640)', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        const MaterialApp(
          home: SportsMergePage(initialLang: 'pt'),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.byType(SportsMergeHeroSection), findsOneWidget);
    });

    testWidgets('T018 [US3]: Layout renders without overflow on desktop (1920x1080)', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        const MaterialApp(
          home: SportsMergePage(initialLang: 'pt'),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.byType(SportsMergeHeroSection), findsOneWidget);
    });

    testWidgets('T021 [US4]: Clicking Apple App Store button displays coming soon notice', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1280, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SportsMergePage(initialLang: 'pt'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Find Apple Store badge button in store badges section
      final appleButtons = find.byWidgetPredicate(
        (widget) =>
            widget is StoreBadgeButton &&
            widget.label == SportsMergeContent.pt.appStoreButtonLabel,
      );
      expect(appleButtons, findsOneWidget);

      await tester.ensureVisible(appleButtons);
      await tester.pumpAndSettle();

      await tester.tap(appleButtons);
      await tester.pump();

      // Verify SnackBar with notice is shown
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text(SportsMergeContent.pt.appStoreNotice), findsOneWidget);
    });
  });
}
