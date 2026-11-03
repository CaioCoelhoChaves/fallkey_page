import 'package:flutter/material.dart';

enum StorePlatform {
  googlePlay,
  appStore,
}

class StoreDestination {
  final StorePlatform platform;
  final String? url;
  final String badgeAssetPath;
  final bool isAvailable;

  const StoreDestination({
    required this.platform,
    this.url,
    required this.badgeAssetPath,
    this.isAvailable = true,
  });
}

class FeatureHighlight {
  final String title;
  final String description;
  final IconData icon;

  const FeatureHighlight({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class ShowcaseMedia {
  final String posterAssetPath;
  final String? videoUrl;
  final List<String> screenshotsPt;
  final List<String> screenshotsEn;

  const ShowcaseMedia({
    required this.posterAssetPath,
    this.videoUrl,
    required this.screenshotsPt,
    required this.screenshotsEn,
  });
}

class LocalizationProfile {
  final String languageCode;
  final String languageLabel;
  final String heroTitle;
  final String heroSubtitle;
  final String playStoreButtonLabel;
  final String appStoreButtonLabel;
  final String appStoreNotice;
  final String featuresTitle;
  final List<FeatureHighlight> features;
  final String privacyPolicyLabel;
  final String supportLabel;
  final String copyrightText;

  const LocalizationProfile({
    required this.languageCode,
    required this.languageLabel,
    required this.heroTitle,
    required this.heroSubtitle,
    required this.playStoreButtonLabel,
    required this.appStoreButtonLabel,
    required this.appStoreNotice,
    required this.featuresTitle,
    required this.features,
    required this.privacyPolicyLabel,
    required this.supportLabel,
    required this.copyrightText,
  });
}

class GamePresentation {
  final String id;
  final String name;
  final String packageName;
  final String iconPath;
  final List<StoreDestination> destinations;
  final ShowcaseMedia media;

  GamePresentation({
    required this.id,
    required this.name,
    required this.packageName,
    required this.iconPath,
    required this.destinations,
    required this.media,
  }) : assert(id == 'sports-merge', 'Game id must be sports-merge'),
       assert(name.isNotEmpty, 'Name cannot be empty'),
       assert(
         RegExp(r'^[a-z]+(\.[a-z0-9_]+)+$').hasMatch(packageName),
         'PackageName must follow reverse domain convention',
       ),
       assert(destinations.isNotEmpty, 'At least one store destination required');
}

class SportsMergeContent {
  static const String googlePlayUrl =
      'https://play.google.com/store/apps/details?id=com.fallkey.sports_merge';
  static const String? appStoreUrl = null;

  static const LocalizationProfile pt = LocalizationProfile(
    languageCode: 'pt',
    languageLabel: 'PT',
    heroTitle: 'Junte as bolas e marque pontos!',
    heroSubtitle:
        'O viciante jogo de física e estratégia esportiva onde bolas iguais se combinam para criar novas modalidades até o troféu final!',
    playStoreButtonLabel: 'Disponível na Google Play',
    appStoreButtonLabel: 'Em breve na App Store',
    appStoreNotice:
        'O jogo Sports Merge estará disponível em breve na App Store para iPhone e iPad!',
    featuresTitle: 'Por que jogar Sports Merge?',
    features: [
      FeatureHighlight(
        title: 'Física Realista',
        description:
            'Cada bola possui peso, elasticidade e dinâmica realista na arena.',
        icon: Icons.sports_soccer,
      ),
      FeatureHighlight(
        title: 'Combos Espetaculares',
        description:
            'Encadeie fusões seguidas para pontuações épicas e efeitos vibrantes.',
        icon: Icons.auto_awesome,
      ),
      FeatureHighlight(
        title: 'Visual Esportivo Único',
        description:
            'Design polido, cores vibrantes e modelos fiéis às maiores modalidades.',
        icon: Icons.sports_basketball,
      ),
      FeatureHighlight(
        title: 'Desafie seus Limites',
        description:
            'Supere seus recordes e dispute com amigos quem alcança a maior fusão.',
        icon: Icons.leaderboard,
      ),
    ],
    privacyPolicyLabel: 'Política de Privacidade',
    supportLabel: 'Central de Suporte',
    copyrightText: '© 2026 FallKey. Todos os direitos reservados.',
  );

  static const LocalizationProfile en = LocalizationProfile(
    languageCode: 'en',
    languageLabel: 'EN',
    heroTitle: 'Merge balls and score high!',
    heroSubtitle:
        'The addictive physics and sports strategy game where matching balls merge into bigger sports until the ultimate championship trophy!',
    playStoreButtonLabel: 'Get it on Google Play',
    appStoreButtonLabel: 'Coming soon to App Store',
    appStoreNotice:
        'Sports Merge will be available soon on the App Store for iPhone and iPad!',
    featuresTitle: 'Why play Sports Merge?',
    features: [
      FeatureHighlight(
        title: 'Realistic Physics',
        description:
            'Every ball features true-to-life weight, bounce, and responsive movement.',
        icon: Icons.sports_soccer,
      ),
      FeatureHighlight(
        title: 'Spectacular Combos',
        description:
            'Chain merges in succession for explosive points and energetic visuals.',
        icon: Icons.auto_awesome,
      ),
      FeatureHighlight(
        title: 'Polished Sports Theme',
        description:
            'Sleek graphics, energetic colors, and authentic sports ball designs.',
        icon: Icons.sports_basketball,
      ),
      FeatureHighlight(
        title: 'Compete for High Scores',
        description:
            'Challenge your strategic skills and share your biggest merge achievements.',
        icon: Icons.leaderboard,
      ),
    ],
    privacyPolicyLabel: 'Privacy Policy',
    supportLabel: 'Support Center',
    copyrightText: '© 2026 FallKey. All rights reserved.',
  );

  static final GamePresentation presentation = GamePresentation(
    id: 'sports-merge',
    name: 'Sports Merge',
    packageName: 'com.fallkey.sports_merge',
    iconPath: 'assets/sports_merge/icon.png',
    destinations: const [
      StoreDestination(
        platform: StorePlatform.googlePlay,
        url: googlePlayUrl,
        badgeAssetPath: 'assets/sports_merge/badges/google_play_badge.png',
        isAvailable: true,
      ),
      StoreDestination(
        platform: StorePlatform.appStore,
        url: appStoreUrl,
        badgeAssetPath: 'assets/sports_merge/badges/apple_store_badge.png',
        isAvailable: false,
      ),
    ],
    media: const ShowcaseMedia(
      posterAssetPath: 'assets/sports_merge/poster.jpeg',
      videoUrl: null,
      screenshotsPt: [
        'assets/sports_merge/screenshots/pt/print0.jpeg',
        'assets/sports_merge/screenshots/pt/print1.jpeg',
        'assets/sports_merge/screenshots/pt/print3.jpeg',
        'assets/sports_merge/screenshots/pt/print4.jpeg',
        'assets/sports_merge/screenshots/pt/print5.jpeg',
      ],
      screenshotsEn: [
        'assets/sports_merge/screenshots/en/print0.jpeg',
        'assets/sports_merge/screenshots/en/print1.jpeg',
        'assets/sports_merge/screenshots/en/print2.jpeg',
        'assets/sports_merge/screenshots/en/print3.jpeg',
        'assets/sports_merge/screenshots/en/print4.jpeg',
        'assets/sports_merge/screenshots/en/print5.jpeg',
      ],
    ),
  );

  static String resolveLanguageCode(String? lang) {
    if (lang == null || lang.trim().isEmpty) return 'pt';
    final normalized = lang.trim().toLowerCase();
    if (normalized.startsWith('pt')) return 'pt';
    return 'en';
  }

  static LocalizationProfile getProfile(String? lang) {
    final code = resolveLanguageCode(lang);
    return code == 'pt' ? pt : en;
  }
}
