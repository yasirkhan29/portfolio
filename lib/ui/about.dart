import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'responsive_widget.dart';
import '../data/skills.dart';
import '../config/constants.dart';
import '../config/colors.dart';
import 'animated_reveal.dart';

class About extends StatelessWidget {
  const About({super.key});

  final String _avatar = 'lib/assets/logo.jpg';
  final String _description =
      "I’m a passionate mobile application developer with strong Flutter and React Native experience, focused on building elegant interfaces, responsive interactions, reliable app architectures, and scalable digital products for Android, iOS, and web.";
  final List<String> _highlights = const [
    'Builds responsive products with production-focused architecture',
    'Creates clean UI systems with attention to motion and usability',
    'Balances design quality, performance, and maintainable code',
    'Delivers API integrations, deployment workflows, third-party integrations, and AI-powered application experiences',
  ];
  final List<_AboutCapability> _capabilities = const [
    _AboutCapability(
      title: 'API Integration',
      description:
          'REST APIs, authentication flows, payment systems, realtime data, and clean service integration.',
      icon: Icons.hub_rounded,
    ),
    _AboutCapability(
      title: 'Deployment',
      description:
          'Play Store, App Store, Firebase hosting, release builds, signing, and production delivery.',
      icon: Icons.rocket_launch_rounded,
    ),
    _AboutCapability(
      title: 'Third-Party Integration',
      description:
          'Maps, analytics, notifications, media services, social login, and external SDK integrations.',
      icon: Icons.extension_rounded,
    ),
    _AboutCapability(
      title: 'AI Applications',
      description:
          'AI-assisted workflows, smart automation, content generation, and user-focused AI features.',
      icon: Icons.auto_awesome_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) => ResponsiveWidget(
        desktopScreen: _buildDesktopAbout(context),
        mobileScreen: _buildMobileAbout(context),
      );

  Widget _buildDesktopAbout(BuildContext context) {
    return Container(
      color: AppColors.black,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .1,
        vertical: 100,
      ),
      child: Column(
        children: [
          AnimatedReveal(
            child: _buildSectionHeading(context, centered: true),
          ),
          const SizedBox(height: 50),
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(36),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: AppColors.halo,
                  blurRadius: 34,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: AnimatedReveal(
                    delay: const Duration(milliseconds: 100),
                    child: _buildProfilePanel(context, imageSize: 280),
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 6,
                  child: AnimatedReveal(
                    delay: const Duration(milliseconds: 220),
                    beginOffset: const Offset(0.06, 0.06),
                    child: _buildAboutContent(context, centered: false),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileAbout(BuildContext context) {
    return Container(
      color: AppColors.black,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .07,
        vertical: 60,
      ),
      child: Column(
        children: [
          AnimatedReveal(child: _buildSectionHeading(context, centered: true)),
          const SizedBox(height: 28),
          AnimatedReveal(
            delay: const Duration(milliseconds: 120),
            child: _buildProfilePanel(context, imageSize: 180),
          ),
          const SizedBox(height: 24),
          AnimatedReveal(
            delay: const Duration(milliseconds: 240),
            child: _buildAboutContent(context, centered: true),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeading(BuildContext context, {required bool centered}) {
    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'ABOUT ME',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: AppColors.primary,
                letterSpacing: 2,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Professional background and core strengths',
          textAlign: centered ? TextAlign.center : TextAlign.left,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 14),
        Container(
          width: 92,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(99),
          ),
        ),
      ],
    );
  }

  Widget _buildProfilePanel(BuildContext context, {required double imageSize}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF13201F), Color(0xFF0D1414)],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: .55),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                _avatar,
                width: imageSize,
                height: imageSize,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Muhammad Yasir Khan',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Flutter Developer • React Native • UI-focused Engineer',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.white.withValues(alpha: .72),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: const [
              _InfoPill(label: 'Experience', value: '5+ Years'),
              _InfoPill(label: 'Projects', value: '29+ Delivered'),
              _InfoPill(label: 'Location', value: 'Islamabad'),
              _InfoPill(label: 'Focus', value: 'Scalable Mobile Apps'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAboutContent(BuildContext context, {required bool centered}) {
    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Building products that look refined and feel smooth',
          textAlign: centered ? TextAlign.center : TextAlign.left,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.white,
              ),
        ),
        const SizedBox(height: 18),
        Text(
          _description,
          textAlign: centered ? TextAlign.center : TextAlign.left,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.textMuted,
                height: 1.9,
              ),
        ),
        const SizedBox(height: 24),
        ..._highlights.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              mainAxisAlignment:
                  centered ? MainAxisAlignment.center : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  margin: const EdgeInsets.only(top: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: .14),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 16,
                    color: AppColors.primaryDark,
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    item,
                    textAlign: centered ? TextAlign.center : TextAlign.left,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.white.withValues(alpha: .82),
                          height: 1.7,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
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
                foregroundColor: AppColors.white,
                side: const BorderSide(color: AppColors.border),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text('Visit LinkedIn'),
            ),
          ],
        ),
        const SizedBox(height: 36),
        Align(
          alignment: centered ? Alignment.center : Alignment.centerLeft,
          child: Text(
            'Professional Focus',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          children: _capabilities
              .map((item) => _buildCapabilityCard(context, item))
              .toList(),
        ),
        const SizedBox(height: 32),
        _buildEducationCard(context, centered: centered),
        const SizedBox(height: 36),
        Align(
          alignment: centered ? Alignment.center : Alignment.centerLeft,
          child: Text(
            'Core Skills',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          children: SKILLS.map(_buildSkill).toList(),
        ),
      ],
    );
  }

  Widget _buildCapabilityCard(BuildContext context, _AboutCapability item) {
    return Container(
      width: 230,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: .14),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(item.icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(height: 14),
          Text(
            item.title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            item.description,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.textMuted,
                  height: 1.6,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationCard(BuildContext context, {required bool centered}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment:
            centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            'Education Background',
            textAlign: centered ? TextAlign.center : TextAlign.left,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'Bachelor of Software Engineering • PEC Registered Engineer',
            textAlign: centered ? TextAlign.center : TextAlign.left,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'Strong engineering foundation with formal software engineering education, professional ethics, and practical product development experience across mobile, web, and deployment workflows.',
            textAlign: centered ? TextAlign.center : TextAlign.left,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.textMuted,
                  height: 1.75,
                ),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadCV() async {
    await launchUrl(Uri.parse(AppConstants.cv));
  }

  Future<void> _openLinkedIn() async {
    await launchUrl(Uri.parse(AppConstants.linkedin));
  }

  Widget _buildSkill(Skill skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        skill.name!,
        style: const TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _AboutCapability {
  final String title;
  final String description;
  final IconData icon;

  const _AboutCapability({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class _InfoPill extends StatelessWidget {
  final String label;
  final String value;

  const _InfoPill({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.glass,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: .6),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
