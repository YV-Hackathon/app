import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/pages/unified_onboarding_page.dart';
import '../../features/onboarding/presentation/pages/loading_screen_page.dart';
import '../../features/onboarding/presentation/pages/sermon_clips_page.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const UnifiedOnboardingPage(),
    ),
    // Legacy routes that redirect to unified onboarding
    GoRoute(
      path: '/welcome',
      name: 'welcome',
      builder: (context, state) => const UnifiedOnboardingPage(),
    ),
    GoRoute(
      path: '/survey-intro',
      name: 'survey-intro',
      builder: (context, state) => const UnifiedOnboardingPage(),
    ),
    GoRoute(
      path: '/question',
      name: 'question',
      builder: (context, state) => const UnifiedOnboardingPage(),
    ),
    GoRoute(
      path: '/teaching-style',
      name: 'teaching-style',
      builder: (context, state) => const UnifiedOnboardingPage(),
    ),
    GoRoute(
      path: '/church-environment',
      name: 'church-environment',
      builder: (context, state) => const UnifiedOnboardingPage(),
    ),
    GoRoute(
      path: '/personalization-intro',
      name: 'personalization-intro',
      builder: (context, state) => const UnifiedOnboardingPage(),
    ),
    GoRoute(
      path: '/personalization-instructions',
      name: 'personalization-instructions',
      builder: (context, state) => const UnifiedOnboardingPage(),
    ),
    GoRoute(
      path: '/playlist-instructions',
      name: 'playlist-instructions',
      builder: (context, state) => const UnifiedOnboardingPage(),
    ),
    GoRoute(
      path: '/loading',
      name: 'loading',
      builder: (context, state) => const LoadingScreenPage(),
    ),
    GoRoute(
      path: '/sermon-clips',
      name: 'sermon-clips',
      builder: (context, state) => const SermonClipsPage(),
    ),

    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    // Add more routes here as you create pages
  ],
);
