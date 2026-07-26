import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_legal.dart';

enum LegalPageType { privacy, terms, healthDisclaimer }

class LegalScreen extends StatefulWidget {
  final LegalPageType type;

  const LegalScreen({super.key, required this.type});

  @override
  State<LegalScreen> createState() => _LegalScreenState();
}

class _LegalScreenState extends State<LegalScreen> {
  String? _body;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final assetPath = switch (widget.type) {
      LegalPageType.privacy => 'assets/legal/privacy_policy.txt',
      LegalPageType.terms => 'assets/legal/terms_of_service.txt',
      LegalPageType.healthDisclaimer => null,
    };

    String body;
    if (assetPath != null) {
      try {
        body = await rootBundle.loadString(assetPath);
      } catch (_) {
        body = widget.type == LegalPageType.privacy
            ? AppLegal.privacySummary
            : 'Terms of Service — see support email.';
      }
    } else {
      body = AppLegal.healthDisclaimer;
    }

    if (mounted) {
      setState(() {
        _body = body;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = switch (widget.type) {
      LegalPageType.privacy => 'Privacy Policy',
      LegalPageType.terms => 'Terms of Service',
      LegalPageType.healthDisclaimer => 'Health Disclaimer',
    };

    final url = switch (widget.type) {
      LegalPageType.privacy => AppLegal.privacyPolicyUrl,
      LegalPageType.terms => AppLegal.termsOfServiceUrl,
      LegalPageType.healthDisclaimer => null,
    };

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(title)),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.info.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.offline_pin, size: 18, color: AppColors.info),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Full policy available offline in the app (no login required).',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _body!,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  if (url != null) ...[
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => _openUrl(context, url),
                        icon: const Icon(Icons.open_in_new_rounded),
                        label: const Text('Open hosted copy (HTTPS)'),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  const Text(
                    'Contact: ${AppLegal.supportEmail}',
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _openUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Could not open browser. The full policy is shown above.',
            ),
          ),
        );
      }
    }
  }
}
