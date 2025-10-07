import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';

class FilterChips extends StatefulWidget {
  final List<String> selectedFilters;
  final Function(List<String>) onFiltersChanged;

  const FilterChips({
    super.key,
    required this.selectedFilters,
    required this.onFiltersChanged,
  });

  @override
  State<FilterChips> createState() => _FilterChipsState();
}

class _FilterChipsState extends State<FilterChips> {
  late List<String> _selectedFilters;

  final List<String> _availableFilters = [
    'Size',
    'Teaching',
    'Worship',
    'Format',
  ];

  @override
  void initState() {
    super.initState();
    _selectedFilters = List.from(widget.selectedFilters);
  }

  void _toggleFilter(String filter) {
    setState(() {
      if (_selectedFilters.contains(filter)) {
        _selectedFilters.remove(filter);
      } else {
        _selectedFilters.add(filter);
      }
    });
    widget.onFiltersChanged(_selectedFilters);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Filter toggle button
          Container(
            width: 40,
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF474545), width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.tune, size: 16, color: AppColors.white),
              onPressed: () {
                // Toggle all filters
                setState(() {
                  if (_selectedFilters.length == _availableFilters.length) {
                    _selectedFilters.clear();
                  } else {
                    _selectedFilters = List.from(_availableFilters);
                  }
                });
                widget.onFiltersChanged(_selectedFilters);
              },
            ),
          ),

          const SizedBox(width: 8),

          // Filter chips
          ..._availableFilters.map((filter) {
            final isSelected = _selectedFilters.contains(filter);
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => _toggleFilter(filter),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF474545),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color:
                        isSelected
                            ? const Color(0xFF217B48).withOpacity(0.2)
                            : Colors.transparent,
                  ),
                  child: Text(
                    filter,
                    style: TextStyle(
                      fontSize: AppFonts.sm,
                      fontWeight: FontWeight.bold,
                      color:
                          isSelected
                              ? const Color(0xFF217B48)
                              : AppColors.white,
                      fontFamily: 'Aktiv Grotesk App',
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
