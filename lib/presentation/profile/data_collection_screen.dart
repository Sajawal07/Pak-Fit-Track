import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/data_collection_registry.dart';

/// In-app mirror of Play Console Data safety — always available offline.
class DataCollectionScreen extends StatelessWidget {
  const DataCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Data we collect'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'This list matches what Pak Fit Track actually collects at runtime. '
            'Use the same answers in Google Play → App content → Data safety.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          ...DataCollectionRegistry.items.map(_itemCard),
          const SizedBox(height: 24),
          const Text(
            'We do NOT collect',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          ...DataCollectionRegistry.notCollected.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('✗ ', style: TextStyle(color: AppColors.error)),
                  Expanded(
                    child: Text(
                      s,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _itemCard(DataCollectionItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.category,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(item.purpose,
              style: const TextStyle(
                  color: AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 4),
          Text('Shared: ${item.shared}',
              style: const TextStyle(
                  color: AppColors.textMuted, fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            'Optional: ${item.optional ? "Yes" : "No"} · '
            'Encrypted in transit: ${item.encryptedInTransit ? "Yes" : "N/A"} · '
            'Deletable: ${item.userCanDelete ? "Yes" : "No"}',
            style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
          ),
          if (item.note != null) ...[
            const SizedBox(height: 4),
            Text(item.note!,
                style: const TextStyle(
                    color: AppColors.primary, fontSize: 11)),
          ],
        ],
      ),
    );
  }
}
