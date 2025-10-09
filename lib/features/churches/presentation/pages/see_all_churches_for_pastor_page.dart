import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../domain/entities/church.dart';
import '../widgets/church_card.dart';

class SeeAllChurchesForPastorPage extends StatelessWidget {
  final List<Church> churches;
  final String pastorName;

  const SeeAllChurchesForPastorPage({
    super.key,
    required this.churches,
    required this.pastorName,
  });

  void _onChurchTap(Church church, BuildContext context) {
    context.push('/church/${church.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tabBarBackground,
      appBar: AppBar(
        backgroundColor: AppColors.tabBarBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.white,
            size: 20,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Churches - $pastorName',
          style: const TextStyle(
            fontSize: AppFonts.lg,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
            fontFamily: 'DM Sans',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // Church list using ChurchCard widgets
              ...churches.map(
                (church) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ChurchCard(
                    church: church,
                    onTap: () => _onChurchTap(church, context),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

