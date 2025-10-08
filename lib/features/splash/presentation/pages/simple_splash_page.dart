import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SimpleSplashPage extends StatefulWidget {
  const SimpleSplashPage({super.key});

  @override
  State<SimpleSplashPage> createState() => _SimpleSplashPageState();
}

class _SimpleSplashPageState extends State<SimpleSplashPage> {
  @override
  void initState() {
    super.initState();
    // Navigate to unified onboarding after 30 seconds
    Future.delayed(const Duration(seconds: 10), () {
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
              // Main content - positioned exactly as in Figma
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo positioned exactly as in Figma (108px, centered)
                    Container(
                      width: 108,
                      height: 108,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(54),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/logo.svg',
                          width: 54,
                          height: 54,
                          colorFilter: const ColorFilter.mode(
                            Color(0xFF112016),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // App Name positioned exactly as in Figma (25px, bold, white, -0.75px letter spacing)
                    const Text(
                      'App Name Here',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.75,
                        fontFamily: 'DM Sans',
                      ),
                      textAlign: TextAlign.center,
                    ),

                    // Loading indicator
                    const SizedBox(height: 32),
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  ],
                ),
              ),

              // YouVersion Logo positioned exactly as in Figma (bottom center, 116.785px width, 37.665px height)
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SvgPicture.asset(
                      'assets/images/youversion_logo.svg',
                      width: 116.785,
                      height: 37.665,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
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
