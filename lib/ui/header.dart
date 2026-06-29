import 'package:flutter/material.dart';
import 'package:portfolio/ui/responsive_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/constants.dart';
import '../config/colors.dart';
import 'animated_reveal.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  final String _name = "Muhammad Yasir Khan";
  final String _job = "Flutter and Cross-Platform Mobile Developer";
  final String _description =
      "I design and build polished, high-performance mobile experiences with Flutter and React Native, focusing on clean architecture, smooth UX, and products that feel reliable in production.";
  final String _avatar = 'lib/assets/logo.jpg';

  @override
  Widget build(BuildContext context) => ResponsiveWidget(
        desktopScreen: _buildDesktopHero(context),
        mobileScreen: _buildMobileHero(context),
      );

  Widget _buildDesktopHero(BuildContext context) {
    final double horizontalPadding = MediaQuery.of(context).size.width * .12;
    return SizedBox(
      height: 400,
      child: Padding(
        padding:
            EdgeInsets.fromLTRB(horizontalPadding, 14, horizontalPadding, 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: constraints.maxWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedReveal(child: _buildBadge()),
                          const SizedBox(height: 14),
                          AnimatedReveal(
                            delay: const Duration(milliseconds: 120),
                            child: _buildHeading(context, textAlign: TextAlign.left),
                          ),
                          const SizedBox(height: 10),
                          AnimatedReveal(
                            delay: const Duration(milliseconds: 220),
                            child: SizedBox(
                              width: 540,
                              child: Text(
                                _description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: Colors.white.withValues(alpha: .78),
                                          height: 1.65,
                                          fontWeight: FontWeight.w400,
                                        ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          AnimatedReveal(
                            delay: const Duration(milliseconds: 320),
                            child: Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                ElevatedButton(
                                  onPressed: _downloadCV,
                                  child: const Text('View Resume'),
                                ),
                                OutlinedButton(
                                  onPressed: _openLinkedIn,
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    side: BorderSide(
                                      color: Colors.white.withValues(alpha: .24),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 22,
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  child: const Text('LinkedIn Profile'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          AnimatedReveal(
                            delay: const Duration(milliseconds: 420),
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: const [
                                _MetricCard(value: '5+', label: 'Years'),
                                _MetricCard(value: '29+', label: 'Projects'),
                                _MetricCard(
                                    value: 'Android & iOS', label: 'Platforms'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 32),
            Expanded(
              flex: 5,
              child: AnimatedReveal(
                delay: const Duration(milliseconds: 280),
                beginOffset: const Offset(0.08, 0.08),
                child: _buildShowcaseCard(height: 320),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileHero(BuildContext context) {
    final double horizontalPadding = MediaQuery.of(context).size.width * .08;
    return SizedBox(
      height: 300,
      child: Padding(
        padding:
            EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedReveal(child: _buildBadge()),
            const SizedBox(height: 16),
            AnimatedReveal(
              delay: const Duration(milliseconds: 180),
              child: _buildHeading(context, textAlign: TextAlign.center),
            ),
            const SizedBox(height: 12),
            AnimatedReveal(
              delay: const Duration(milliseconds: 280),
              child: Text(
                _description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white.withValues(alpha: .76),
                      height: 1.7,
                    ),
              ),
            ),
            const SizedBox(height: 18),
            AnimatedReveal(
              delay: const Duration(milliseconds: 360),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  ElevatedButton(
                    onPressed: _downloadCV,
                    child: const Text('View Resume'),
                  ),
                  OutlinedButton(
                    onPressed: _openLinkedIn,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side:
                          BorderSide(color: Colors.white.withValues(alpha: .24)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text('LinkedIn'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AnimatedReveal(
              delay: const Duration(milliseconds: 420),
              child: const Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: [
                  _CompactMetric(value: '5+', label: 'Years'),
                  _CompactMetric(value: '29+', label: 'Projects'),
                  _CompactMetric(value: 'Android & iOS Apps', label: 'Android & iOS Apps'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.glass,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.border),
      ),
      child: const Text(
        'Every great app starts with a great idea. I turn those ideas into powerful mobile experiences.',
        style: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
          letterSpacing: .2,
        ),
      ),
    );
  }

  Widget _buildHeading(BuildContext context, {required TextAlign textAlign}) {
    final bool isMobile = MediaQuery.of(context).size.width <= 600;
    return Column(
      crossAxisAlignment: textAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          'Crafting modern mobile products',
          textAlign: textAlign,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: AppColors.primary,
                letterSpacing: 1.6,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 14),
        RichText(
          textAlign: textAlign,
          text: TextSpan(
            style: TextStyle(
              fontSize: isMobile ? 26 : 42,
              height: 1.05,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
            children: [
              const TextSpan(text: 'I\'m '),
              TextSpan(
                text: _name,
                style: const TextStyle(color: AppColors.primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          _job,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white.withValues(alpha: .92),
                fontSize: isMobile ? 15 : 19,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  Widget _buildShowcaseCard({required double height}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF101818),
            Color(0xFF0C1313),
          ],
        ),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.halo,
            blurRadius: 42,
            spreadRadius: 4,
            offset: const Offset(0, 22),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 28,
            right: 28,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.halo,
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildMiniDot(AppColors.success),
                      const SizedBox(width: 8),
                      const Text(
                        'Modern mobile apps with seamless performance',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Center(
                    child: Container(
                      width: height * .42,
                      height: height * .42,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: .5),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: .18),
                            blurRadius: 32,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(_avatar, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.glassStrong,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _ShowcaseInfo(title: 'CI/CD', value: 'Codemagic'),
                        _ShowcaseInfo(title: 'Payments', value: 'Stripe , In-App Payments, GoPayFast'),
                        // _ShowcaseInfo(title: 'Focus', value: 'Scalable Mobile Apps'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: -18,
            top: 70,
            child: _buildFloatingTag('Flutter', Icons.flutter_dash_rounded),
          ),
          Positioned(
            right: -14,
            bottom: 82,
            child:
                _buildFloatingTag('React Native', Icons.phone_android_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingTag(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .14),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primaryDark, size: 18),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniDot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Future<void> _downloadCV() async {
    await launchUrl(Uri.parse(AppConstants.cv));
  }

  Future<void> _openLinkedIn() async {
    await launchUrl(Uri.parse(AppConstants.linkedin));
  }
}

class _MetricCard extends StatelessWidget {
  final String value;
  final String label;

  const _MetricCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 116),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.glass,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: .82),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompactMetric extends StatelessWidget {
  final String value;
  final String label;

  const _CompactMetric({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.glass,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: .78),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShowcaseInfo extends StatelessWidget {
  final String title;
  final String value;

  const _ShowcaseInfo({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withValues(alpha: .58),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
