import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import 'churches_page.dart';
import 'discover_page.dart';
import 'sermons_page.dart';
import 'settings_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ChurchesPage(),
    const DiscoverPage(),
    const SermonsPage(),
    const SettingsPage(),
  ];

  Widget _buildTabIcon(IconData icon, bool isActive) {
    return Container(
      width: 24,
      height: 24,
      child: Icon(icon, color: AppColors.white, size: 24),
    );
  }

  Widget _buildTabContent(String label, IconData icon, bool isActive) {
    return Container(
      height: 52,
      width: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(height: 32, child: _buildTabIcon(icon, isActive)),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
              height: 16 / 12, // line height
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _pages),
      ),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.zero,
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.tabBarBackground,
            border: Border(
              top: BorderSide(color: AppColors.tabBarBorder, width: 1),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _currentIndex = 0),
                  child: Opacity(
                    opacity: _currentIndex == 0 ? 1.0 : 0.5,
                    child: _buildTabContent(
                      'Churches',
                      Icons.home,
                      _currentIndex == 0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _currentIndex = 1),
                  child: Opacity(
                    opacity: _currentIndex == 1 ? 1.0 : 0.5,
                    child: _buildTabContent(
                      'Discover',
                      Icons.search,
                      _currentIndex == 1,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _currentIndex = 2),
                  child: Opacity(
                    opacity: _currentIndex == 2 ? 1.0 : 0.5,
                    child: _buildTabContent(
                      'Sermons',
                      Icons.play_circle_outline,
                      _currentIndex == 2,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _currentIndex = 3),
                  child: Opacity(
                    opacity: _currentIndex == 3 ? 1.0 : 0.5,
                    child: _buildTabContent(
                      'Settings',
                      Icons.settings_outlined,
                      _currentIndex == 3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
