import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Shows why a permission is needed before the system prompt (Play best practice).
Future<bool> showPermissionRationale(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: AppColors.surface,
      title: Text(title,
          style: const TextStyle(color: AppColors.textPrimary)),
      content: Text(message,
          style: const TextStyle(color: AppColors.textSecondary, height: 1.4)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Not now'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return result == true;
}
