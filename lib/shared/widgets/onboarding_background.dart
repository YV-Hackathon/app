import 'package:flutter/material.dart';

class OnboardingBackground extends StatelessWidget {
  final Widget child;

  const OnboardingBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF121212),
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        child: Stack(
          children: [
            // Blob C - Top left (responsive positioning) - BEHIND content
            Positioned(
              left:
                  -MediaQuery.of(context).size.width *
                  0.9, // -338.328125 / 375 ≈ -0.9
              top:
                  MediaQuery.of(context).size.height *
                  0.05, // 38.802734375 / 812 ≈ 0.05
              child: IgnorePointer(
                child: Container(
                  width:
                      MediaQuery.of(context).size.width *
                      1.5, // 563.1163828969002 / 375 ≈ 1.5
                  height:
                      MediaQuery.of(context).size.height *
                      0.7, // 565.9548702836037 / 812 ≈ 0.7
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF3BC175).withOpacity(0.36),
                        const Color(0xFF3BC175).withOpacity(0.1),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.6, 1.0],
                    ),
                  ),
                ),
              ),
            ),

            // Blob C - Bottom right (responsive positioning) - BEHIND content
            Positioned(
              left: MediaQuery.of(context).size.width * 0.19, // 70 / 375 ≈ 0.19
              top:
                  MediaQuery.of(context).size.height * 0.46, // 370 / 812 ≈ 0.46
              child: IgnorePointer(
                child: Container(
                  width:
                      MediaQuery.of(context).size.width *
                      1.08, // 405 / 375 ≈ 1.08
                  height:
                      MediaQuery.of(context).size.height *
                      0.51, // 414 / 812 ≈ 0.51
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF3BC175).withOpacity(0.36),
                        const Color(0xFF3BC175).withOpacity(0.1),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.6, 1.0],
                    ),
                  ),
                ),
              ),
            ),

            // Main content - ON TOP of blobs
            child,
          ],
        ),
      ),
    );
  }
}
