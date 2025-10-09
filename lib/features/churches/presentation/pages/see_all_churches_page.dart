import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../domain/entities/church.dart';
import '../../domain/entities/church_section.dart';
import '../widgets/church_list_item.dart';
import '../widgets/filter_chips.dart';

class SeeAllChurchesPage extends StatefulWidget {
  final ChurchSection section;

  const SeeAllChurchesPage({super.key, required this.section});

  @override
  State<SeeAllChurchesPage> createState() => _SeeAllChurchesPageState();
}

class _SeeAllChurchesPageState extends State<SeeAllChurchesPage> {
  List<String> _selectedFilters = [];
  List<Church> _filteredChurches = [];

  @override
  void initState() {
    super.initState();
    _filteredChurches = widget.section.churches;
  }

  void _onFiltersChanged(List<String> filters) {
    setState(() {
      _selectedFilters = filters;
      _applyFilters();
    });
  }

  void _applyFilters() {
    if (_selectedFilters.isEmpty) {
      _filteredChurches = widget.section.churches;
    } else {
      _filteredChurches =
          widget.section.churches.where((church) {
            return _selectedFilters.any(
              (filter) => church.attributes.any(
                (attribute) =>
                    attribute.toLowerCase().contains(filter.toLowerCase()),
              ),
            );
          }).toList();
    }
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
                'Showing ${_filteredChurches.length} results',
                style: const TextStyle(
                  fontSize: AppFonts.sm,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFBFBDBD),
                  fontFamily: 'Aktiv Grotesk App',
                ),
              ),

              const SizedBox(height: 16),

              // Filter chips
              FilterChips(
                selectedFilters: _selectedFilters,
                onFiltersChanged: _onFiltersChanged,
              ),

              const SizedBox(height: 24),

              // Church list
              if (_filteredChurches.isEmpty)
                _buildEmptyState()
              else
                ..._filteredChurches.asMap().entries.map((entry) {
                  final index = entry.key;
                  final church = entry.value;
                  final isLast = index == _filteredChurches.length - 1;

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

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: AppColors.white.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No churches found',
            style: TextStyle(
              fontSize: AppFonts.lg,
              fontWeight: FontWeight.bold,
              color: AppColors.white.withOpacity(0.8),
              fontFamily: 'DM Sans',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters to see more results',
            style: TextStyle(
              fontSize: AppFonts.sm,
              fontWeight: FontWeight.w400,
              color: AppColors.white.withOpacity(0.6),
              fontFamily: 'Aktiv Grotesk App',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
