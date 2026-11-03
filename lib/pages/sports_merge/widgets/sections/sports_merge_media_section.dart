import 'package:flutter/material.dart';
import '../../models/sports_merge_content.dart';

class SportsMergeMediaSection extends StatelessWidget {
  final LocalizationProfile profile;
  final bool isMobile;

  const SportsMergeMediaSection({
    super.key,
    required this.profile,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final media = SportsMergeContent.presentation.media;
    final screenshots = profile.languageCode == 'pt'
        ? media.screenshotsPt
        : media.screenshotsEn;

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Main Poster Showcase with Future Sports Arena Glassmorphism
              Semantics(
                label: 'Sports Merge Gameplay Poster',
                image: true,
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: isMobile ? 380 : 540,
                    maxWidth: 720,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0x33FFFFFF),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF06B6D4).withAlpha(50),
                        blurRadius: 36,
                        spreadRadius: 2,
                        offset: const Offset(0, 8),
                      ),
                      BoxShadow(
                        color: Colors.black.withAlpha(180),
                        blurRadius: 28,
                        offset: const Offset(0, 16),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      media.posterAssetPath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 300,
                        color: const Color(0xFF1E293B),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.sports_soccer,
                          color: Color(0xFF06B6D4),
                          size: 64,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Gameplay Screenshots Gallery
              Text(
                profile.languageCode == 'pt'
                    ? 'Capturas de Tela do Jogo'
                    : 'Gameplay Screenshots',
                style: TextStyle(
                  fontSize: isMobile ? 20 : 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFF97316), // Vibrant Orange
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                height: isMobile ? 260 : 360,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: screenshots.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final screenshotPath = screenshots[index];
                    return Semantics(
                      label: 'Screenshot ${index + 1}',
                      image: true,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0x33FFFFFF),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(120),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            screenshotPath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 150,
                              color: const Color(0xFF1E293B),
                              child: const Icon(
                                Icons.image_not_supported,
                                color: Colors.white24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
