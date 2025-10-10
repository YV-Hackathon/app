import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../domain/entities/church.dart';

class ChurchListItem extends StatelessWidget {
  final Church church;
  final VoidCallback? onTap;
  final bool showDivider;

  const ChurchListItem({
    super.key,
    required this.church,
    this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Church content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Attribute pills
                      if (church.attributes.isNotEmpty) ...[
                        Wrap(
                          spacing: 8,
                          children:
                              church.attributes.take(1).map((attribute) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFF217B48),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Text(
                                    attribute,
                                    style: const TextStyle(
                                      fontSize: AppFonts.xs,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.white,
                                      fontFamily: 'Aktiv Grotesk App',
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                        const SizedBox(height: 8),
                      ],

                      // Church name
                      Text(
                        church.name,
                        style: const TextStyle(
                          fontSize: AppFonts.lg,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                          fontFamily: 'DM Sans',
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Church description
                      Text(
                        church.description,
                        style: const TextStyle(
                          fontSize: AppFonts.sm,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFBFBDBD),
                          fontFamily: 'Aktiv Grotesk App',
                          height: 1.25,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // Location info
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Color(0xFFBFBDBD),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '21.8 miles',
                            style: const TextStyle(
                              fontSize: AppFonts.xs,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFBFBDBD),
                              fontFamily: 'Aktiv Grotesk App',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Church avatar
                Container(
                  width: 86,
                  height: 86,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(86),
                    image: DecorationImage(
                      image: NetworkImage(church.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Divider
        if (showDivider)
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(vertical: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Color(0xFF353333),
                  Colors.transparent,
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),
      ],
    );
  }
}
