import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../domain/entities/pastor.dart';
import '../widgets/pastor_card.dart';

class SeeAllPastorsPage extends StatelessWidget {
  final List<Pastor> pastors;

  const SeeAllPastorsPage({super.key, required this.pastors});

  void _onPastorTap(Pastor pastor, BuildContext context) {
    context.push('/pastor/${pastor.id}');
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
        title: const Text(
          'All Pastors',
          style: TextStyle(
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

              // Pastor list using PastorCard widgets
              ...pastors.map(
                (pastor) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: PastorCard(
                    pastor: pastor,
                    onTap: () => _onPastorTap(pastor, context),
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
