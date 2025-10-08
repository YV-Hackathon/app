import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SurveyIntroPage extends StatefulWidget {
  final VoidCallback? onNext;

  const SurveyIntroPage({super.key, this.onNext});

  @override
  State<SurveyIntroPage> createState() => _SurveyIntroPageState();
}

class _SurveyIntroPageState extends State<SurveyIntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            // Main content - centered
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // House-cross icon (72px)
                  Container(
                    width: 72,
                    height: 72,
                    child: Center(
                      child: Image.asset(
                        'assets/images/house-cross.png',
                        width: 72,
                        height: 72,
                        errorBuilder:
                            (context, error, stackTrace) => const Icon(
                              Icons.home,
                              color: Colors.green,
                              size: 72,
                            ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Main text
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Answer a few simple questions, and we\'ll help guide you to the right church family',
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
                ],
              ),
            ),

            // Begin Survey button at bottom
            Positioned(
              bottom: 40,
              left: 24,
              right: 24,
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // Use the callback if provided, otherwise use default navigation
                    if (widget.onNext != null) {
                      widget.onNext!();
                    } else {
                      context.go('/onboarding');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF217B48), // Green button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(48),
                    ),
                  ),
                  child: const Text(
                    'Begin Survey',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Aktiv Grotesk App',
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
