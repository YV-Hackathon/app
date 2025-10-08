import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/onboarding_background.dart';
import 'welcome_onboarding_page.dart';
import 'survey_intro_page.dart';
import 'simple_onboarding_page.dart';
import 'question_page.dart';
import 'teaching_style_page.dart';
import 'church_environment_page.dart';
import 'personalization_intro_page.dart';
import 'personalization_instructions_page.dart';
import 'playlist_instructions_page.dart';
import 'sermon_clips_page.dart';

class UnifiedOnboardingPage extends ConsumerStatefulWidget {
  const UnifiedOnboardingPage({super.key});

  @override
  ConsumerState<UnifiedOnboardingPage> createState() =>
      _UnifiedOnboardingPageState();
}

class _UnifiedOnboardingPageState extends ConsumerState<UnifiedOnboardingPage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    print(
      '🔹 _nextPage called. Current page: $_currentPage, Total pages: ${_getOnboardingScreens().length}',
    );

    if (_currentPage < _getOnboardingScreens().length - 2) {
      // Navigate to next page in PageView (0-7)
      print(
        '🔹 Navigating to next page in PageView (index ${_currentPage + 1})',
      );
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (_currentPage == _getOnboardingScreens().length - 2) {
      // Transition to sermon clips page (final page)
      print('🔹 Transitioning to sermon clips page (final onboarding page)');
      setState(() {
        _currentPage = _getOnboardingScreens().length - 1;
      });
    } else {
      // This should not be called anymore since SermonClipsPage navigates directly to /home
      print('🔹 Navigating to home from page $_currentPage');
      context.go('/home');
    }
  }

  List<Widget> _getOnboardingScreens() {
    return [
      WelcomeOnboardingPage(onNext: _nextPage),
      SurveyIntroPage(onNext: _nextPage),
      SimpleOnboardingPage(onNext: _nextPage),
      QuestionPage(onNext: _nextPage),
      TeachingStylePage(onNext: _nextPage),
      ChurchEnvironmentPage(onNext: _nextPage),
      PersonalizationIntroPage(onNext: _nextPage),
      PersonalizationInstructionsPage(onNext: _nextPage),
      PlaylistInstructionsPage(onNext: _nextPage),
      SermonClipsPage(), // Final page - navigates directly to /home
    ];
  }

  @override
  Widget build(BuildContext context) {
    print(
      '🏗️ Building UnifiedOnboardingPage. Current page: $_currentPage, Total pages: ${_getOnboardingScreens().length}',
    );

    // If we're on the sermon clips page, render it directly
    // to avoid PageView interference with CardSwiper gestures
    if (_currentPage == _getOnboardingScreens().length - 1) {
      print('🏗️ Rendering SermonClipsPage (final page)');
      return OnboardingBackground(child: const SermonClipsPage());
    }

    print('🏗️ Rendering PageView with $_currentPage');

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: OnboardingBackground(
        child: PageView.builder(
          controller: _pageController,
          physics:
              const NeverScrollableScrollPhysics(), // Disable manual swiping
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemCount:
              _getOnboardingScreens().length - 1, // Exclude sermon clips page
          itemBuilder: (context, index) {
            return _getOnboardingScreens()[index];
          },
        ),
      ),
    );
  }
}
