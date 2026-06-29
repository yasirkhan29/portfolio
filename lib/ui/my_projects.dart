import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'responsive_widget.dart';
import '../data/projects.dart';
import '../config/styles.dart';
import '../config/colors.dart';

class MyProjects extends StatefulWidget {
  const MyProjects({super.key});

  @override
  State<MyProjects> createState() => _MyProjectsState();
}

class _MyProjectsState extends State<MyProjects> {
  final PageController _desktopController =
      PageController(viewportFraction: .42);
  final PageController _mobileController =
      PageController(viewportFraction: .9);
  Timer? _autoSlideTimer;

  int _desktopIndex = 0;
  int _mobileIndex = 0;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktopScreen: _buildDesktopSlider(context),
      mobileScreen: _buildMobileSlider(context),
    );
  }

  Widget _buildDesktopSlider(BuildContext context) {
    return Container(
      color: AppColors.black,
      padding: const EdgeInsets.symmetric(vertical: 90),
      child: Column(
        children: [
          Text('MY PROJECTS', style: AppStyles.title),
          const SizedBox(height: 10),
          Container(width: 100, height: 3, color: AppColors.primary),
          const SizedBox(height: 3),
          Container(width: 75, height: 3, color: AppColors.primary),
          const SizedBox(height: 18),
          Text(
            'A curated slider to explore selected work and shipped products',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.textMuted,
                ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 500,
            child: PageView.builder(
              controller: _desktopController,
              itemCount: PROJECTS.length,
              onPageChanged: (value) => setState(() => _desktopIndex = value),
              itemBuilder: (context, index) => _buildCarouselItem(
                context,
                index,
                controller: _desktopController,
                project: PROJECTS[index],
                isDesktop: true,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildSliderFooter(
            currentIndex: _desktopIndex,
            controller: _desktopController,
          ),
        ],
      ),
    );
  }

  Widget _buildMobileSlider(BuildContext context) {
    return Container(
      color: AppColors.black,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .05,
        vertical: 60,
      ),
      child: Column(
        children: [
          Text(
            'MY PROJECTS',
            style: AppStyles.title,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Container(width: 75, height: 3, color: AppColors.primary),
          const SizedBox(height: 3),
          Container(width: 50, height: 3, color: AppColors.primary),
          const SizedBox(height: 18),
          Text(
            'Swipe through the portfolio slider to explore all projects',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.textMuted,
                  height: 1.7,
                ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 560,
            child: PageView.builder(
              controller: _mobileController,
              itemCount: PROJECTS.length,
              onPageChanged: (value) => setState(() => _mobileIndex = value),
              itemBuilder: (context, index) => _buildCarouselItem(
                context,
                index,
                controller: _mobileController,
                project: PROJECTS[index],
                isDesktop: false,
              ),
            ),
          ),
          const SizedBox(height: 18),
          _buildSliderFooter(
            currentIndex: _mobileIndex,
            controller: _mobileController,
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselItem(
    BuildContext context,
    int index, {
    required PageController controller,
    required Project project,
    required bool isDesktop,
  }) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double page = index.toDouble();
        if (controller.hasClients && controller.position.hasContentDimensions) {
          page = controller.page ?? controller.initialPage.toDouble();
        }
        final double distance = (page - index).abs();
        final double scale = (1 - (distance * .12)).clamp(.86, 1.0);
        final double opacity = (1 - (distance * .35)).clamp(.45, 1.0);
        final double verticalPadding = (distance * 26).clamp(0, 26);

        return Center(
          child: Opacity(
            opacity: opacity,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, verticalPadding, 10, verticalPadding),
              child: Transform.scale(
                scale: scale,
                child: child,
              ),
            ),
          ),
        );
      },
      child: _buildProjectCard(
        context,
        project,
        isDesktop: isDesktop,
        projectIndex: index + 1,
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Project project,
      {required bool isDesktop, required int projectIndex}) {
    final bool hasUrl = project.url != null && project.url!.trim().isNotEmpty;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.halo,
            blurRadius: 30,
            spreadRadius: 2,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: hasUrl ? () => launchUrl(Uri.parse(project.url!)) : null,
          borderRadius: BorderRadius.circular(30),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: isDesktop ? 6 : 5,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _buildProjectImage(project.image!, height: double.infinity),
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.glassStrong,
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Text(
                            projectIndex.toString().padLeft(2, '0'),
                            style: const TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        right: 16,
                        bottom: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.glassStrong,
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: const Text(
                            'Mobile Product',
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: isDesktop ? 5 : 6,
                  child: Padding(
                    padding: EdgeInsets.all(isDesktop ? 22 : 18),
                    child: _buildProjectContent(
                      context,
                      project,
                      hasUrl,
                      compact: isDesktop,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectImage(String imagePath, {required double height}) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(imagePath, fit: BoxFit.cover),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Color(0x22000000),
                Color(0x55000000),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectContent(
      BuildContext context, Project project, bool hasUrl,
      {required bool compact}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: .14),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        'Featured Project',
                        style: TextStyle(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      project.name!,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: compact ? 24 : 26,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      project.description!,
                      maxLines: compact ? 3 : 4,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.white.withValues(alpha: .82),
                            height: 1.65,
                            fontSize: 14,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: project.skills!
                          .take(compact ? 4 : 5)
                          .map(
                            (s) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceAlt,
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Text(
                                s,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed:
                          hasUrl ? () => launchUrl(Uri.parse(project.url!)) : null,
                      child: const Text('Open Project'),
                    ),
                    SizedBox(
                      width: compact ? 170 : 220,
                      child: Text(
                        hasUrl
                            ? 'Live / Store Link'
                            : 'Private project link unavailable',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      _autoAdvance(_desktopController, _desktopIndex);
      _autoAdvance(_mobileController, _mobileIndex);
    });
  }

  void _autoAdvance(PageController controller, int currentIndex) {
    if (!mounted || !controller.hasClients || PROJECTS.isEmpty) {
      return;
    }

    final int nextIndex =
        currentIndex >= PROJECTS.length - 1 ? 0 : currentIndex + 1;

    controller.animateToPage(
      nextIndex,
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _desktopController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  Widget _buildSliderFooter({
    required int currentIndex,
    required PageController controller,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildArrowButton(
          icon: Icons.arrow_back_rounded,
          onPressed: currentIndex > 0
              ? () => controller.previousPage(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOutCubic,
                  )
              : null,
        ),
        const SizedBox(width: 16),
        Wrap(
          spacing: 8,
          children: List.generate(
            PROJECTS.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: index == currentIndex ? 28 : 10,
              height: 10,
              decoration: BoxDecoration(
                color: index == currentIndex
                    ? AppColors.primary
                    : AppColors.white.withValues(alpha: .22),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        _buildArrowButton(
          icon: Icons.arrow_forward_rounded,
          onPressed: currentIndex < PROJECTS.length - 1
              ? () => controller.nextPage(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOutCubic,
                  )
              : null,
        ),
      ],
    );
  }

  Widget _buildArrowButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: onPressed != null ? AppColors.glass : AppColors.glassStrong,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(
          icon,
          color: onPressed != null
              ? AppColors.white
              : AppColors.white.withValues(alpha: .28),
        ),
      ),
    );
  }

}
