// lib/widgets/contact_actions.dart
// Click-to-call and open-website action buttons with safe launching.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

/// Normalises a human-entered phone string into a `tel:` URI-safe value.
String _sanitizePhone(String raw) {
  // Keep leading "+" and digits only.
  final plus = raw.trimLeft().startsWith('+') ? '+' : '';
  return plus + raw.replaceAll(RegExp(r'[^0-9]'), '');
}

/// Ensures a website string has an http(s) scheme before launching.
String _normalizeUrl(String raw) {
  final trimmed = raw.trim();
  if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
    return trimmed;
  }
  return 'https://$trimmed';
}

Future<void> launchPhoneCall(BuildContext context, String phone) async {
  final uri = Uri.parse('tel:${_sanitizePhone(phone)}');
  try {
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      _showFallback(context, label: 'Call', value: phone);
    }
  } catch (_) {
    if (context.mounted) {
      _showFallback(context, label: 'Call', value: phone);
    }
  }
}

Future<void> launchWebsite(BuildContext context, String url) async {
  final uri = Uri.parse(_normalizeUrl(url));
  try {
    // externalApplication opens in the user's default browser / chrome tab,
    // which is the correct "new tab, secure" behaviour on every platform.
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      _showFallback(context, label: 'Website', value: url);
    }
  } catch (_) {
    if (context.mounted) {
      _showFallback(context, label: 'Website', value: url);
    }
  }
}

void _showFallback(BuildContext context,
    {required String label, required String value}) {
  // Copy to clipboard as a friendly fallback and inform the user.
  Clipboard.setData(ClipboardData(text: value));
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('$label unavailable — "$value" copied to clipboard'),
      duration: const Duration(seconds: 3),
    ),
  );
}

/// Compact button row: Call / Website. Either can be omitted.
class ContactActions extends StatelessWidget {
  final String? phone;
  final String? website;
  final bool compact;

  const ContactActions({
    super.key,
    this.phone,
    this.website,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final hasPhone = phone != null && phone!.trim().isNotEmpty;
    final hasSite = website != null && website!.trim().isNotEmpty;
    if (!hasPhone && !hasSite) return const SizedBox.shrink();

    return Row(
      children: [
        if (hasPhone)
          Expanded(
            child: _ActionButton(
              icon: Icons.phone_outlined,
              label: 'Call',
              color: AppTheme.primaryGreen,
              onTap: () => launchPhoneCall(context, phone!),
              tooltip: 'Call $phone',
            ),
          ),
        if (hasPhone && hasSite) const SizedBox(width: 10),
        if (hasSite)
          Expanded(
            child: _ActionButton(
              icon: Icons.public,
              label: compact ? 'Website' : 'Visit Website',
              color: AppTheme.skyBlue,
              onTap: () => launchWebsite(context, website!),
              tooltip: 'Open $website in browser',
            ),
          ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final String tooltip;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        label: tooltip,
        child: Material(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 16, color: color),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
