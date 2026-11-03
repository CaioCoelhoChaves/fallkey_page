import 'package:flutter_test/flutter_test.dart';
import 'package:fallkey_page/pages/sports_merge/models/sports_merge_content.dart';

void main() {
  group('SportsMergeContent Unit Tests', () {
    test('GamePresentation entity matches specification and domain rules', () {
      final presentation = SportsMergeContent.presentation;
      expect(presentation.id, equals('sports-merge'));
      expect(presentation.name, equals('Sports Merge'));
      expect(presentation.packageName, equals('com.fallkey.sports_merge'));
      expect(presentation.iconPath, equals('assets/sports_merge/icon.png'));
      expect(presentation.destinations.length, equals(2));
      expect(presentation.media.posterAssetPath, equals('assets/sports_merge/poster.jpeg'));
      expect(presentation.media.screenshotsPt, isNotEmpty);
      expect(presentation.media.screenshotsEn, isNotEmpty);
    });

    test('Store destinations have valid platforms, badges, and Google Play URL', () {
      final destinations = SportsMergeContent.presentation.destinations;
      final googlePlay = destinations.firstWhere((d) => d.platform == StorePlatform.googlePlay);
      final appStore = destinations.firstWhere((d) => d.platform == StorePlatform.appStore);

      expect(googlePlay.isAvailable, isTrue);
      expect(
        googlePlay.url,
        equals('https://play.google.com/store/apps/details?id=com.fallkey.sports_merge'),
      );
      expect(googlePlay.badgeAssetPath, equals('assets/sports_merge/badges/google_play_badge.png'));

      expect(appStore.isAvailable, isFalse);
      expect(appStore.url, isNull);
      expect(appStore.badgeAssetPath, equals('assets/sports_merge/badges/apple_store_badge.png'));
    });

    test('LocalizationProfile for PT is complete and has between 3 and 5 features', () {
      final pt = SportsMergeContent.pt;
      expect(pt.languageCode, equals('pt'));
      expect(pt.languageLabel, equals('PT'));
      expect(pt.heroTitle.trim(), isNotEmpty);
      expect(pt.heroSubtitle.trim(), isNotEmpty);
      expect(pt.playStoreButtonLabel.trim(), isNotEmpty);
      expect(pt.appStoreButtonLabel.trim(), isNotEmpty);
      expect(pt.appStoreNotice.trim(), isNotEmpty);
      expect(pt.featuresTitle.trim(), isNotEmpty);
      expect(pt.privacyPolicyLabel.trim(), isNotEmpty);
      expect(pt.supportLabel.trim(), isNotEmpty);
      expect(pt.copyrightText.trim(), isNotEmpty);
      expect(pt.features.length, inInclusiveRange(3, 5));

      for (final feature in pt.features) {
        expect(feature.title.trim(), isNotEmpty);
        expect(feature.description.trim(), isNotEmpty);
      }
    });

    test('LocalizationProfile for EN is complete and has between 3 and 5 features', () {
      final en = SportsMergeContent.en;
      expect(en.languageCode, equals('en'));
      expect(en.languageLabel, equals('EN'));
      expect(en.heroTitle.trim(), isNotEmpty);
      expect(en.heroSubtitle.trim(), isNotEmpty);
      expect(en.playStoreButtonLabel.trim(), isNotEmpty);
      expect(en.appStoreButtonLabel.trim(), isNotEmpty);
      expect(en.appStoreNotice.trim(), isNotEmpty);
      expect(en.featuresTitle.trim(), isNotEmpty);
      expect(en.privacyPolicyLabel.trim(), isNotEmpty);
      expect(en.supportLabel.trim(), isNotEmpty);
      expect(en.copyrightText.trim(), isNotEmpty);
      expect(en.features.length, inInclusiveRange(3, 5));

      for (final feature in en.features) {
        expect(feature.title.trim(), isNotEmpty);
        expect(feature.description.trim(), isNotEmpty);
      }
    });

    test('resolveLanguageCode correctly parses various inputs and defaults', () {
      expect(SportsMergeContent.resolveLanguageCode(null), equals('pt'));
      expect(SportsMergeContent.resolveLanguageCode(''), equals('pt'));
      expect(SportsMergeContent.resolveLanguageCode('   '), equals('pt'));
      expect(SportsMergeContent.resolveLanguageCode('pt'), equals('pt'));
      expect(SportsMergeContent.resolveLanguageCode('PT'), equals('pt'));
      expect(SportsMergeContent.resolveLanguageCode('pt-BR'), equals('pt'));
      expect(SportsMergeContent.resolveLanguageCode('pt_BR'), equals('pt'));
      expect(SportsMergeContent.resolveLanguageCode('en'), equals('en'));
      expect(SportsMergeContent.resolveLanguageCode('EN'), equals('en'));
      expect(SportsMergeContent.resolveLanguageCode('en-US'), equals('en'));
      expect(SportsMergeContent.resolveLanguageCode('es'), equals('en'));
      expect(SportsMergeContent.resolveLanguageCode('fr'), equals('en'));
    });

    test('getProfile returns expected profile based on language parameter', () {
      expect(SportsMergeContent.getProfile('pt').languageCode, equals('pt'));
      expect(SportsMergeContent.getProfile('pt-BR').languageCode, equals('pt'));
      expect(SportsMergeContent.getProfile(null).languageCode, equals('pt'));
      expect(SportsMergeContent.getProfile('en').languageCode, equals('en'));
      expect(SportsMergeContent.getProfile('en-US').languageCode, equals('en'));
      expect(SportsMergeContent.getProfile('de').languageCode, equals('en'));
    });
  });
}
