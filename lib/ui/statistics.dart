import 'package:flutter/material.dart';

import 'responsive_widget.dart';
import 'icon.dart';
import '../config/colors.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktopScreen: Container(
        height: 400,
        color: AppColors.black.withValues(alpha: .74),
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .1,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatistic(
              context,
              'lib/assets/briefcase.png',
              '5+',
              'Years of Experience',
            ),
            _buildStatistic(
              context,
              'lib/assets/app.png',
              '29+',
              'Projects Done',
            ),
            _buildStatistic(
              context,
              'lib/assets/happy.png',
              '50+',
              'Happy Clients',
            ),
            _buildStatistic(
              context,
              'lib/assets/coffee.png',
              '∞',
              'Coffee Cups',
            ),
          ],
        ),
      ),
      mobileScreen: Container(
        color: AppColors.black.withValues(alpha: .74),
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .1,
          vertical: 50,
        ),
        child: Column(
          children: [
            _buildStatistic(
              context,
              'lib/assets/briefcase.png',
              '5+',
              'Years of Experience',
            ),
            const SizedBox(height: 50),
            _buildStatistic(
              context,
              'lib/assets/app.png',
              '29+',
              'Projects Done',
            ),
            const SizedBox(height: 50),
            _buildStatistic(
              context,
              'lib/assets/happy.png',
              '50+',
              'Happy Clients',
            ),
            const SizedBox(height: 50),
            _buildStatistic(
              context,
              'lib/assets/coffee.png',
              '∞',
              'Coffee Cups',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatistic(
      BuildContext context, String icon, String total, String description) {
    return ResponsiveWidget(
      desktopScreen: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(icon, size: 50),
          const SizedBox(height: 5),
          Text(
            total,
            style: TextStyle(
              color: Colors.white,
              fontSize: 50,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      mobileScreen: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(icon, size: 40),
          const SizedBox(height: 5),
          Text(
            total,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
