import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/sports_merge_content.dart';
import '../components/store_badge_button.dart';

class SportsMergeHeroSection extends StatelessWidget {
  final LocalizationProfile profile;
  final bool isMobile;
  final Widget languageSelector;
  final Future<void> Function(BuildContext context)? onGooglePlayTap;
  final void Function(BuildContext context)? onAppleStoreTap;

  const SportsMergeHeroSection({
    super.key,
    required this.profile,
    required this.isMobile,
    required this.languageSelector,
    this.onGooglePlayTap,
    this.onAppleStoreTap,
  });

  Future<void> _handleGooglePlay(BuildContext context) async {
    if (onGooglePlayTap != null) {
      await onGooglePlayTap!(context);
      return;
    }

    final uri = Uri.parse(SportsMergeContent.googlePlayUrl);
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        _showErrorSnackBar(context, 'Não foi possível abrir o link da loja.');
      }
    } catch (_) {
      if (context.mounted) {
        _showErrorSnackBar(context, 'Erro ao abrir a Google Play Store.');
      }
    }
  }

  void _handleAppleStore(BuildContext context) {
    if (onAppleStoreTap != null) {
      onAppleStoreTap!(context);
      return;
    }

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info_outline, color: Color(0xFF06B6D4)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                profile.appStoreNotice,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1E293B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0x33FFFFFF)),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final playDestination = SportsMergeContent.presentation.destinations.firstWhere(
      (d) => d.platform == StorePlatform.googlePlay,
    );
    final appleDestination = SportsMergeContent.presentation.destinations.firstWhere(
      (d) => d.platform == StorePlatform.appStore,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 24 : 40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Navigation Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Semantics(
                    label: 'FallKey Games',
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/fallkey_logo.png',
                          height: 36,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.sports_esports,
                            color: Color(0xFF06B6D4),
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'FALLKEY',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  languageSelector,
                ],
              ),
              SizedBox(height: isMobile ? 32 : 56),

              // Game Icon Badge with Future Sports Arena Glow
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0x33FFFFFF),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF06B6D4).withAlpha(90),
                      blurRadius: 40,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: const Color(0xFFF97316).withAlpha(50),
                      blurRadius: 30,
                      spreadRadius: 1,
                      offset: const Offset(0, 16),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    SportsMergeContent.presentation.iconPath,
                    width: isMobile ? 104 : 136,
                    height: isMobile ? 104 : 136,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                SportsMergeContent.presentation.name,
                style: TextStyle(
                  fontSize: isMobile ? 30 : 46,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Hero Headline in Cyan Neon
              Text(
                profile.heroTitle,
                style: TextStyle(
                  fontSize: isMobile ? 20 : 28,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF06B6D4),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Hero Subtitle
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Text(
                  profile.heroSubtitle,
                  style: TextStyle(
                    fontSize: isMobile ? 15 : 17,
                    height: 1.5,
                    color: const Color(0xFF94A3B8),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 36),

              // Consolidated Store Badges (Single source of conversion in Hero)
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isMobile ? 360 : 540,
                ),
                child: isMobile
                    ? Column(
                        children: [
                          StoreBadgeButton(
                            badgeAssetPath: playDestination.badgeAssetPath,
                            label: profile.playStoreButtonLabel,
                            onPressed: () => _handleGooglePlay(context),
                            isFullWidth: true,
                          ),
                          const SizedBox(height: 14),
                          StoreBadgeButton(
                            badgeAssetPath: appleDestination.badgeAssetPath,
                            label: profile.appStoreButtonLabel,
                            onPressed: () => _handleAppleStore(context),
                            isFullWidth: true,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: StoreBadgeButton(
                              badgeAssetPath: playDestination.badgeAssetPath,
                              label: profile.playStoreButtonLabel,
                              onPressed: () => _handleGooglePlay(context),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Flexible(
                            child: StoreBadgeButton(
                              badgeAssetPath: appleDestination.badgeAssetPath,
                              label: profile.appStoreButtonLabel,
                              onPressed: () => _handleAppleStore(context),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
