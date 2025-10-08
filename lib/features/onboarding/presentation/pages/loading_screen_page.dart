import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/loading_screen.dart';
import '../providers/loading_screen_provider.dart';

class LoadingScreenPage extends ConsumerStatefulWidget {
  const LoadingScreenPage({super.key});

  @override
  ConsumerState<LoadingScreenPage> createState() => _LoadingScreenPageState();
}

class _LoadingScreenPageState extends ConsumerState<LoadingScreenPage> {
  @override
  void initState() {
    super.initState();
    // Start processing and navigate to home after delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(loadingScreenNotifierProvider.notifier).startProcessing();

      // Simulate processing time and navigate to sermon clips
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          ref.read(loadingScreenNotifierProvider.notifier).stopProcessing();
          // Navigate directly to sermon clips screen
          context.go('/sermon-clips');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final loadingScreenState = ref.watch(loadingScreenNotifierProvider);

    if (loadingScreenState.loadingScreens.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF121212),
        body: Center(
          child: Text(
            'No loading screen found.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    final loadingScreen = loadingScreenState.loadingScreens.first;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo (placeholder)
              Container(
                width: 108,
                height: 108,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(54),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.church,
                  color: Color(0xFF121212),
                  size: 54,
                ),
              ),

              const SizedBox(height: 32),

              // Title
              Text(
                loadingScreen.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -0.75,
                  height: 1.0,
                ),
              ),

              const SizedBox(height: 24),

              // Loading indicator
              if (loadingScreenState.isProcessing)
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3BC175)),
                  strokeWidth: 2,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
