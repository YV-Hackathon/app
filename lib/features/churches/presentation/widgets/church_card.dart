import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/church.dart';

class ChurchCard extends StatelessWidget {
  final Church church;
  final VoidCallback? onTap;

  const ChurchCard({super.key, required this.church, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(124),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF474545)),
          borderRadius: BorderRadius.circular(124),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(church.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    church.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      fontFamily: 'DM Sans',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    church.attributes.isNotEmpty ? church.attributes.first : '',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFBFBDBD),
                      fontFamily: 'Aktiv Grotesk App',
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 24, color: AppColors.white),
          ],
        ),
      ),
    );
  }
}
