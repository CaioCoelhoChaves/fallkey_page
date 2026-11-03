import 'package:flutter/material.dart';
import '../../models/sports_merge_content.dart';

class SportsMergeHeroSection extends StatelessWidget {
  final LocalizationProfile profile;
  final bool isMobile;
  final Widget languageSelector;
  final VoidCallback onDownloadTap;

  const SportsMergeHeroSection({
    super.key,
    required this.profile,
    required this.isMobile,
    required this.languageSelector,
    required this.onDownloadTap,
  });

  @override
  Widget build(BuildContext context) {
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
                            color: Colors.blueAccent,
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

              // Game Icon Badge
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2E6FF2).withAlpha(80),
                      blurRadius: 36,
                      spreadRadius: 4,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Image.asset(
                    SportsMergeContent.presentation.iconPath,
                    width: isMobile ? 100 : 128,
                    height: isMobile ? 100 : 128,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                SportsMergeContent.presentation.name,
                style: TextStyle(
                  fontSize: isMobile ? 28 : 42,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Hero Headline
              Text(
                profile.heroTitle,
                style: TextStyle(
                  fontSize: isMobile ? 20 : 26,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF60A5FA),
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
              const SizedBox(height: 32),

              // Primary CTA Button
              Semantics(
                button: true,
                label: profile.playStoreButtonLabel,
                child: SizedBox(
                  width: isMobile ? double.infinity : null,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: onDownloadTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E6FF2),
                      foregroundColor: Colors.white,
                      elevation: 4,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    icon: const Icon(Icons.download_rounded, size: 22),
                    label: Text(
                      profile.playStoreButtonLabel,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
