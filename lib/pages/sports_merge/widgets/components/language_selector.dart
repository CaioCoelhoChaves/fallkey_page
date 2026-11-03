import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  final String currentLanguageCode;
  final ValueChanged<String> onLanguageChanged;

  const LanguageSelector({
    super.key,
    required this.currentLanguageCode,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isPt = currentLanguageCode.toLowerCase().startsWith('pt');

    return Semantics(
      label: 'Alternar idioma / Change language',
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B).withAlpha(200), // Slate translucent
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0x33FFFFFF)), // Glassmorphism
        ),
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOption(
              label: 'PT',
              code: 'pt',
              isSelected: isPt,
              semanticLabel: 'Português',
            ),
            const SizedBox(width: 4),
            _buildOption(
              label: 'EN',
              code: 'en',
              isSelected: !isPt,
              semanticLabel: 'English',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required String label,
    required String code,
    required bool isSelected,
    required String semanticLabel,
  }) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: semanticLabel,
      child: Material(
        color: isSelected ? const Color(0xFF06B6D4) : Colors.transparent, // Cyan Neon
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () => onLanguageChanged(code),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            constraints: const BoxConstraints(minWidth: 44, minHeight: 36),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF94A3B8),
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
