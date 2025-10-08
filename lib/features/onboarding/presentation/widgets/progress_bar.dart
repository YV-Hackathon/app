import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback? onSkip;

  const ProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Progress indicators
        Expanded(
          child: Row(
            children: List.generate(
              totalSteps,
              (index) => Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(
                    right: index < totalSteps - 1 ? 16 : 0,
                  ),
                  decoration: BoxDecoration(
                    color:
                        index <= currentStep
                            ? Colors.white
                            : const Color(0xFF353333),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 24),
        // Skip button
        GestureDetector(
          onTap: onSkip,
          child: const Text(
            'Skip',
            style: TextStyle(
              fontFamily: 'Aktiv Grotesk App',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.0,
            ),
          ),
        ),
      ],
    );
  }
}



