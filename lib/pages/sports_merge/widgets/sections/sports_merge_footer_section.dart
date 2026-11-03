import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/sports_merge_content.dart';

class SportsMergeFooterSection extends StatelessWidget {
  final LocalizationProfile profile;

  const SportsMergeFooterSection({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
      decoration: const BoxDecoration(
        color: Color(0xFF07080A),
        border: Border(
          top: BorderSide(color: Color(0xFF1F2430), width: 1),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 24,
                runSpacing: 12,
                children: [
                  Semantics(
                    button: true,
                    label: profile.privacyPolicyLabel,
                    child: TextButton(
                      onPressed: () => context.go('/sports-merge/privacy'),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF9AA5B8),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      child: Text(profile.privacyPolicyLabel),
                    ),
                  ),
                  const Text(
                    '•',
                    style: TextStyle(color: Color(0xFF4A5568)),
                  ),
                  Semantics(
                    button: true,
                    label: profile.supportLabel,
                    child: TextButton(
                      onPressed: () => context.go(
                        '/sports-merge/support?lang=${profile.languageCode}',
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF9AA5B8),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      child: Text(profile.supportLabel),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                profile.copyrightText,
                style: const TextStyle(
                  color: Color(0xFF718096),
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
