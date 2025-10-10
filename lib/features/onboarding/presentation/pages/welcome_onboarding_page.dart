import 'package:flutter/material.dart';

class WelcomeOnboardingPage extends StatefulWidget {
  final VoidCallback? onNext;

  const WelcomeOnboardingPage({super.key, this.onNext});

  @override
  State<WelcomeOnboardingPage> createState() => _WelcomeOnboardingPageState();
}

class _WelcomeOnboardingPageState extends State<WelcomeOnboardingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _firstTextAnimation;
  late Animation<double> _secondTextAnimation;
  late Animation<Offset> _firstTextSlideAnimation;
  late Animation<Offset> _secondTextSlideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    );

    // First text animation
    _firstTextAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
      ),
    );

    _firstTextSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.6),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
      ),
    );

    // Second text animation
    _secondTextAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.15, 0.55, curve: Curves.easeOut),
      ),
    );

    _secondTextSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.6),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.15, 0.55, curve: Curves.easeOut),
      ),
    );

    // Start animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            // Main content - centered text
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // "Hi, I'm [Product Name]" in green with animation
                  SlideTransition(
                    position: _firstTextSlideAnimation,
                    child: FadeTransition(
                      opacity: _firstTextAnimation,
                      child: const Text(
                        'Hi, I\'m PewPal',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3BC175), // Green color from Figma
                          letterSpacing: -0.75,
                          fontFamily: 'DM Sans',
                          height: 1.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // "Together, we'll find a church family..." in white with animation
                  SlideTransition(
                    position: _secondTextSlideAnimation,
                    child: FadeTransition(
                      opacity: _secondTextAnimation,
                      child: const Text(
                        'Together, we\'ll find a church family where you can grow and belong',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: -0.75,
                          fontFamily: 'DM Sans',
                          height: 1.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Continue button at bottom
            Positioned(
              bottom: 40,
              left: 24,
              right: 24,
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // Use the callback if provided, otherwise do nothing
                    // Navigation is handled by the PageView in UnifiedOnboardingPage
                    if (widget.onNext != null) {
                      widget.onNext!();
                    }
                    // If no callback is provided, the button does nothing
                    // This prevents navigation to non-existent routes
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF217B48), // Green button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(48),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
