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
              // Main Poster Showcase
              Semantics(
                label: 'Sports Merge Gameplay Poster',
                image: true,
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: isMobile ? 380 : 540,
                    maxWidth: 720,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF1E293B), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(150),
                        blurRadius: 28,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      media.posterAssetPath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 300,
                        color: const Color(0xFF131826),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.sports_soccer,
                          color: Colors.white38,
                          size: 64,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 36),

              // Gameplay Screenshots Gallery
              Text(
                profile.languageCode == 'pt'
                    ? 'Capturas de Tela do Jogo'
                    : 'Gameplay Screenshots',
                style: TextStyle(
                  fontSize: isMobile ? 18 : 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFE2E8F0),
                ),
              ),
              const SizedBox(height: 18),

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
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF1E293B),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Image.asset(
                            screenshotPath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 150,
                              color: const Color(0xFF131826),
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
