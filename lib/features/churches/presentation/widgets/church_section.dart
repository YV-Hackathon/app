import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../domain/entities/church.dart';
import '../../domain/entities/church_section.dart';
import 'church_list_item.dart';

class ChurchSectionWidget extends StatelessWidget {
  final ChurchSection section;
  final Function(Church)? onChurchTap;
  final VoidCallback? onSeeAllTap;

  const ChurchSectionWidget({
    super.key,
    required this.section,
    this.onChurchTap,
    this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              section.title,
              style: const TextStyle(
                fontSize: AppFonts.xxl,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                fontFamily: 'Aktiv Grotesk App',
              ),
            ),
            if (section.showSeeAll)
              GestureDetector(
                onTap: onSeeAllTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'See all',
                      style: TextStyle(
                        fontSize: AppFonts.xs,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                        fontFamily: 'Aktiv Grotesk App',
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
          ],
        ),

        const SizedBox(height: 24),

        // Church list
        ...section.churches.asMap().entries.map((entry) {
          final index = entry.key;
          final church = entry.value;
          final isLast = index == section.churches.length - 1;

          return ChurchListItem(
            church: church,
            onTap: () => onChurchTap?.call(church),
            showDivider: !isLast,
          );
        }).toList(),
      ],
    );
  }
}
