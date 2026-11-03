import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'models/sports_merge_content.dart';
import 'widgets/components/language_selector.dart';
import 'widgets/sections/sports_merge_footer_section.dart';
import 'widgets/sections/sports_merge_hero_section.dart';
import 'widgets/sections/sports_merge_media_section.dart';
import 'widgets/sections/sports_merge_features_section.dart';
import 'widgets/sections/sports_merge_store_badges_section.dart';

class SportsMergePage extends StatefulWidget {
  final String? initialLang;

  const SportsMergePage({
    super.key,
    this.initialLang,
  });

  @override
  State<SportsMergePage> createState() => _SportsMergePageState();
}

class _SportsMergePageState extends State<SportsMergePage> {
  late String _currentLang;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _storeBadgesKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _currentLang = SportsMergeContent.resolveLanguageCode(widget.initialLang);
  }

  @override
  void didUpdateWidget(covariant SportsMergePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialLang != oldWidget.initialLang && widget.initialLang != null) {
      final newLang = SportsMergeContent.resolveLanguageCode(widget.initialLang);
      if (newLang != _currentLang) {
        setState(() {
          _currentLang = newLang;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onLanguageChanged(String newCode) {
    if (_currentLang == newCode) return;
    setState(() {
      _currentLang = newCode;
    });

    // Synchronize URL query parameter without full-page reload
    try {
      context.go('/sports-merge?lang=$_currentLang');
    } catch (_) {
      // In isolated widget tests, context.go may not have an active router
    }
  }

  void _scrollToDownload() {
    final context = _storeBadgesKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = SportsMergeContent.getProfile(_currentLang);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;

          return SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SportsMergeHeroSection(
                  profile: profile,
                  isMobile: isMobile,
                  languageSelector: LanguageSelector(
                    currentLanguageCode: _currentLang,
                    onLanguageChanged: _onLanguageChanged,
                  ),
                  onDownloadTap: _scrollToDownload,
                ),
                SportsMergeMediaSection(
                  profile: profile,
                  isMobile: isMobile,
                ),
                SportsMergeFeaturesSection(
                  profile: profile,
                  isMobile: isMobile,
                ),
                KeyedSubtree(
                  key: _storeBadgesKey,
                  child: SportsMergeStoreBadgesSection(
                    profile: profile,
                    isMobile: isMobile,
                  ),
                ),
                SportsMergeFooterSection(
                  profile: profile,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
