import 'package:flutter/material.dart';
import 'package:portfolio/ui/responsive_widget.dart';

import '../config/styles.dart';
import '../config/colors.dart';
import 'icon.dart';

class WorkingProcess extends StatelessWidget {
  const WorkingProcess({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktopScreen: Container(
        color: AppColors.white,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .1,
          vertical: 100,
        ),
        child: Column(
          children: [
            Text(
              'WORKING PROCESS',
              style: AppStyles.title.copyWith(color: AppColors.primaryDark),
            ),
            Container(width: 100, height: 3, color: AppColors.primary),
            const SizedBox(height: 3),
            Container(width: 75, height: 3, color: AppColors.primary),
            const SizedBox(height: 18),
            Text(
              'A focused workflow from planning to design and clean delivery',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.textMuted,
                  ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: __buildProcess(
                      context,
                      '01.',
                      'lib/assets/plan.png',
                      'Plan',
                      'Outline what the project needs to achieve, Gather information about technologies, user needs, and similar projects, Sketch out basic layouts and user flows'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: __buildProcess(
                      context,
                      '02.',
                      'lib/assets/desing.png',
                      'Design',
                      'Create visual designs based on wireframes, ensuring usability and aesthetics,  Build interactive prototypes to visualize user interactions and flow, Gather feedback, refine designs, and finalize UI elements'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: __buildProcess(
                      context,
                      '03.',
                      'lib/assets/code.png',
                      'Code',
                      'code based on finalized designs, focusing on UI components and interactions, '),
                )
              ],
            ),
          ],
        ),
      ),
      mobileScreen: Container(
        color: AppColors.white,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .08,
          vertical: 50,
        ),
        child: Column(
          children: [
            Text(
              'WORKING PROCESS',
              style: AppStyles.title.copyWith(color: AppColors.primaryDark),
              textAlign: TextAlign.center,
            ),
            Container(width: 75, height: 3, color: AppColors.primary),
            const SizedBox(height: 3),
            Container(width: 50, height: 3, color: AppColors.primary),
            const SizedBox(height: 18),
            Text(
              'A focused workflow from planning to design and clean delivery',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.textMuted,
                    height: 1.7,
                  ),
            ),
            const SizedBox(height: 50),
            __buildProcess(context, '01.', 'lib/assets/plan.png', 'Plan',
                'Outline what the project needs to achieve, Gather information about technologies, user needs, and similar projects, Sketch out basic layouts and user flows'),
            __buildProcess(context, '02.', 'lib/assets/desing.png', 'Design',
                'Create visual designs based on wireframes, ensuring usability and aesthetics,  Build interactive prototypes to visualize user interactions and flow, Gather feedback, refine designs, and finalize UI elements'),
            __buildProcess(context, '03.', 'lib/assets/code.png', 'Code',
                'code based on finalized designs, focusing on UI components and interactions, '),
          ],
        ),
      ),
    );
  }

  Widget __buildProcess(BuildContext context, String index, String iconPath,
      String title, String description) {
    return Card(
      color: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text(
                index,
                style: TextStyle(
                  color: AppColors.primaryDark,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Divider(color: AppColors.border),
            const SizedBox(height: 10),
            AppIcon(iconPath, color: AppColors.primaryDark, size: 40),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(
                color: AppColors.black.withValues(alpha: .8),
                height: 1.7,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
