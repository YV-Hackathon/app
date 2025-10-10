import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../domain/entities/church.dart';
import '../../domain/entities/church_section.dart';
import '../widgets/church_list_item.dart';

class SeeAllChurchesPage extends StatefulWidget {
  final ChurchSection section;

  const SeeAllChurchesPage({super.key, required this.section});

  @override
  State<SeeAllChurchesPage> createState() => _SeeAllChurchesPageState();
}

class _SeeAllChurchesPageState extends State<SeeAllChurchesPage> {
  @override
  void initState() {
    super.initState();
  }

  void _onChurchTap(Church church) {
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
          widget.section.title,
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
              const SizedBox(height: 16),

              // Results count
              Text(
                'Showing ${widget.section.churches.length} results',
                style: const TextStyle(
                  fontSize: AppFonts.sm,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFBFBDBD),
                  fontFamily: 'Aktiv Grotesk App',
                ),
              ),

              const SizedBox(height: 24),

              // Church list
              ...widget.section.churches.asMap().entries.map((entry) {
                final index = entry.key;
                final church = entry.value;
                final isLast = index == widget.section.churches.length - 1;

                return ChurchListItem(
                  church: church,
                  onTap: () => _onChurchTap(church),
                  showDivider: !isLast,
                );
              }).toList(),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
