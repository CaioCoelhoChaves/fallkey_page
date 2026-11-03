import 'package:flutter/material.dart';

/// Reusable store badge button complying strictly with official Google Play
/// Lockups & Badges and Apple App Store Marketing Guidelines.
class StoreBadgeButton extends StatefulWidget {
  final String badgeAssetPath;
  final String label;
  final VoidCallback? onPressed;
  final bool isFullWidth;
  final double height;

  const StoreBadgeButton({
    super.key,
    required this.badgeAssetPath,
    required this.label,
    required this.onPressed,
    this.isFullWidth = false,
    this.height = 54,
  });

  @override
  State<StoreBadgeButton> createState() => _StoreBadgeButtonState();
}

class _StoreBadgeButtonState extends State<StoreBadgeButton> {
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: widget.label,
      enabled: widget.onPressed != null,
      child: FocusableActionDetector(
        onShowFocusHighlight: (focused) => setState(() => _isFocused = focused),
        onShowHoverHighlight: (hovered) => setState(() => _isHovered = hovered),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          transform: Matrix4.diagonal3Values(
            _isHovered ? 1.03 : 1.0,
            _isHovered ? 1.03 : 1.0,
            1.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isFocused
                  ? const Color(0xFF06B6D4) // Cyan Neon focus ring
                  : _isHovered
                      ? const Color(0x6606B6D4)
                      : Colors.transparent,
              width: 2,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xFF06B6D4).withAlpha(40),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(8),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 48,
                  maxHeight: widget.height,
                  minWidth: widget.isFullWidth ? double.infinity : 180,
                ),
                child: Image.asset(
                  widget.badgeAssetPath,
                  height: widget.height,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: widget.height,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0x33FFFFFF)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        widget.label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
