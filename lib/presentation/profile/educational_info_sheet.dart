import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_legal.dart';

class EducationalInfoSheet extends StatelessWidget {
  const EducationalInfoSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const EducationalInfoSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Health Metrics Guide\n(صحت اور فٹنس گائیڈ)',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.warning.withValues(alpha: 0.35),
                    ),
                  ),
                  child: const Text(
                    AppLegal.healthDisclaimer,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      height: 1.45,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildSection(
                  'What are BMI, BMR, & TDEE?',
                  'یہ کیا ہیں اور ان کا کیا فائدہ ہے؟',
                  Icons.monitor_weight_outlined,
                  [
                    _buildItem(
                      'BMI (Body Mass Index)',
                      'A measure of body fat based on height and weight. It tells you if you are in a healthy weight range.',
                      'یہ آپ کے وزن اور قد کا تناسب ہے جو بتاتا ہے کہ آپ کا وزن صحت مند حد میں ہے یا نہیں۔',
                    ),
                    _buildItem(
                      'BMR (Basal Metabolic Rate)',
                      'The minimum calories your body needs to function at rest (just to stay alive).',
                      'بی ایم آر (BMR) وہ کیلیریز ہیں جو آپ کے جسم کو آرام کی حالت میں (جیسے سوتے ہوئے) زندہ رہنے کے لیے درکار ہوتی ہیں۔',
                    ),
                    _buildItem(
                      'TDEE (Total Daily Energy Expenditure)',
                      'Total calories you burn in a day, including physical activity. To lose weight, you must eat less than your TDEE.',
                      'یہ وہ کل کیلیریز ہیں جو آپ دن بھر میں (کام کاج اور ورزش ملا کر) جلاتے ہیں۔ وزن کم کرنے کے لیے آپ کو TDEE سے کم کھانا ہوتا ہے۔',
                    ),
                  ],
                ),
                const Divider(height: 32, color: AppColors.surfaceLight),
                _buildSection(
                  'Body Measurements',
                  'جسم کی پیمائش کیسے کریں؟',
                  Icons.straighten_outlined,
                  [
                    _buildItem(
                      'Why Measure?',
                      'The weighing scale doesn\'t tell the full story. You might be losing fat but gaining muscle. Measurements show your true progress.',
                      'صرف وزن کا کانٹا دیکھنا کافی نہیں۔ اکثر وزن وہی رہتا ہے کیونکہ چربی کم ہو رہی ہوتی ہے اور پٹھے (muscle) بن رہے ہوتے ہیں۔ پیمائش سے آپ کو اپنی اصلی اور صحیح پراگریس (progress) پتہ چلتی ہے۔',
                    ),
                    _buildItem(
                      'Waist (کمر)',
                      'Measure around your natural waist, just above the belly button.',
                      'اپنی ناف کے تھوڑا سا اوپر سے پیمائش کریں۔',
                    ),
                    _buildItem(
                      'Neck (گردن)',
                      'Measure around the thickest part of your neck.',
                      'اپنی گردن کے درمیانی اور تھوڑے موٹے حصے سے پیمائش کریں۔',
                    ),
                    _buildItem(
                      'Hip (کولہے)',
                      'Measure around the widest part of your buttocks.',
                      'کولہے کے سب سے چوڑے حصے پر انچی ٹیپ رکھ کر پیمائش کریں۔',
                    ),
                  ],
                ),
                const Divider(height: 32, color: AppColors.surfaceLight),
                _buildSection(
                  'Daily Tracking',
                  'روزانہ ریکارڈ کیوں ضروری ہے؟',
                  Icons.track_changes_outlined,
                  [
                    _buildItem(
                      'Importance of Daily Logging',
                      'Logging your weight, food, and measurements daily builds discipline. It provides the app with accurate data to correctly adjust your targets and show realistic trends.',
                      'روزانہ اپنا وزن، خوراک اور پیمائش ایپ میں ڈالنے سے آپ کی عادت بنتی ہے۔ اس سے ایپ کو آپ کا بالکل درست ڈیٹا ملتا ہے جس سے آپ کے ٹارگٹس بالکل ٹھیک ایڈجسٹ ہوتے ہیں اور آپ کو اپنی محنت کا صحیح رزلٹ نظر آتا ہے۔',
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Got it! (سمجھ آ گیا)'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String titleEn, String titleUr, IconData icon, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleEn,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    titleUr,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildItem(String title, String descEn, String descUr) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 4),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.surfaceLight.withValues(alpha: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              descEn,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              descUr,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
