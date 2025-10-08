import 'package:flutter/material.dart';

class OnboardingButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isLoading;

  const OnboardingButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isPrimary = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: isPrimary ? const Color(0xFF217B48) : const Color(0xFF232121),
        borderRadius: BorderRadius.circular(48),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(48),
          child: Center(
            child:
                isLoading
                    ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                    : Text(
                      text,
                      style: TextStyle(
                        fontFamily: 'Aktiv Grotesk App',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color:
                            isPrimary ? Colors.white : const Color(0xFF909090),
                        height: 1.0,
                      ),
                    ),
          ),
        ),
      ),
    );
  }
}
