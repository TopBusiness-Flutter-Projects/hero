
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class DotesWidget extends StatelessWidget {
  DotesWidget({Key? key, required this.page, required this.length})
      : super(key: key);
  int page = 0;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
            length,
                (index) => index == page
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                height: 12,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.primary,
                ),
              ),
            )
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: AppColors.hint,
                ),
              ),
            ))
      ],
    );
  }
}
