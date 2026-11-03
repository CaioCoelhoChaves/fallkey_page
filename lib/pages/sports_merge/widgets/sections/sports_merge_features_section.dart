import 'package:flutter/material.dart';
import '../../models/sports_merge_content.dart';

class SportsMergeFeaturesSection extends StatelessWidget {
  final LocalizationProfile profile;
  final bool isMobile;

  const SportsMergeFeaturesSection({
    super.key,
    required this.profile,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 32 : 48,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                profile.featuresTitle,
                style: TextStyle(
                  fontSize: isMobile ? 22 : 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF06B6D4), // Cyan Neon
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 36),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 768;
                  final crossAxisCount = isWide ? 2 : 1;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: profile.features.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      mainAxisExtent: isMobile ? 152 : 136,
                    ),
                    itemBuilder: (context, index) {
                      final feature = profile.features[index];
                      final isEven = index.isEven;

                      return Container(
                        padding: EdgeInsets.all(isMobile ? 16 : 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B).withAlpha(220), // Translucent Slate
                          borderRadius: BorderRadius.circular(24), // 24px radius
                          border: Border.all(
                            color: const Color(0x33FFFFFF), // Glassmorphism subtle border
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isEven
                                  ? const Color(0xFF06B6D4).withAlpha(25)
                                  : const Color(0xFFF97316).withAlpha(25),
                              blurRadius: 18,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isEven
                                    ? const Color(0xFF06B6D4).withAlpha(35)
                                    : const Color(0xFFF97316).withAlpha(35),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isEven
                                      ? const Color(0xFF06B6D4).withAlpha(80)
                                      : const Color(0xFFF97316).withAlpha(80),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                feature.icon,
                                color: isEven
                                    ? const Color(0xFF06B6D4)
                                    : const Color(0xFFF97316),
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    feature.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    feature.description,
                                    style: const TextStyle(
                                      color: Color(0xFF94A3B8),
                                      fontSize: 13,
                                      height: 1.4,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
