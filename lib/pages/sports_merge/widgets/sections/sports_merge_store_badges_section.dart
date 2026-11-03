import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/sports_merge_content.dart';
import '../components/store_badge_button.dart';

class SportsMergeStoreBadgesSection extends StatelessWidget {
  final LocalizationProfile profile;
  final bool isMobile;

  const SportsMergeStoreBadgesSection({
    super.key,
    required this.profile,
    required this.isMobile,
  });

  Future<void> _handleGooglePlay(BuildContext context) async {
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
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.blueAccent),
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
        backgroundColor: const Color(0xFF1E2230),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF333B50)),
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
    final playDestination = SportsMergeContent.presentation.destinations
        .firstWhere((d) => d.platform == StorePlatform.googlePlay);
    final appleDestination = SportsMergeContent.presentation.destinations
        .firstWhere((d) => d.platform == StorePlatform.appStore);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 32 : 48,
        horizontal: isMobile ? 16 : 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                profile.languageCode == 'pt'
                    ? 'Baixe agora e comece a jogar!'
                    : 'Download now and start playing!',
                style: TextStyle(
                  fontSize: isMobile ? 22 : 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                profile.languageCode == 'pt'
                    ? 'Disponível gratuitamente para dispositivos Android e em breve no iOS.'
                    : 'Free to play on Android devices and coming soon to iOS.',
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF9AA5B8),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              if (isMobile)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StoreBadgeButton(
                      badgeAssetPath: playDestination.badgeAssetPath,
                      label: profile.playStoreButtonLabel,
                      isFullWidth: true,
                      onPressed: () => _handleGooglePlay(context),
                    ),
                    const SizedBox(height: 14),
                    StoreBadgeButton(
                      badgeAssetPath: appleDestination.badgeAssetPath,
                      label: profile.appStoreButtonLabel,
                      isFullWidth: true,
                      onPressed: () => _handleAppleStore(context),
                    ),
                  ],
                )
              else
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 16,
                  children: [
                    StoreBadgeButton(
                      badgeAssetPath: playDestination.badgeAssetPath,
                      label: profile.playStoreButtonLabel,
                      isFullWidth: false,
                      onPressed: () => _handleGooglePlay(context),
                    ),
                    StoreBadgeButton(
                      badgeAssetPath: appleDestination.badgeAssetPath,
                      label: profile.appStoreButtonLabel,
                      isFullWidth: false,
                      onPressed: () => _handleAppleStore(context),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
