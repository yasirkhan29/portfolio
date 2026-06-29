import 'package:flutter/material.dart';

import 'colors.dart';

mixin AppStyles {
  static final TextStyle title = TextStyle(
    color: AppColors.white.withValues(alpha: .92),
    fontSize: 35,
    fontWeight: FontWeight.w700,
  );
}
