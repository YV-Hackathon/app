import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/splash_provider.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Navigate to onboarding after 10 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/onboarding');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF112016),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF112016),
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Main content - centered
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo (108x108px)
                    Container(
                      width: 108,
                      height: 108,

                      child: Center(
                        child: Image.asset('assets/images/Logo.png'),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // App Name
                    const Text(
                      'PewPal',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.75,
                        fontFamily: 'DM Sans',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // YouVersion Logo at bottom
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    'assets/images/youversion_logo.png',
                    width: 116.785,
                    height: 37.665,
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
