import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/onboarding_background.dart';

class FinalLoadingPage extends ConsumerStatefulWidget {
  final VoidCallback? onNext;

  const FinalLoadingPage({super.key, this.onNext});

  @override
  ConsumerState<FinalLoadingPage> createState() => _FinalLoadingPageState();
}

class _FinalLoadingPageState extends ConsumerState<FinalLoadingPage> {
  @override
  void initState() {
    super.initState();
    print('FinalLoadingPage: initState called');
    // Auto-navigate immediately
    if (mounted) {
      print('FinalLoadingPage: Auto-navigating immediately');
      if (widget.onNext != null) {
        widget.onNext!();
      } else {
        context.go('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: OnboardingBackground(
        child: SafeArea(
          child: Stack(
            children: [
              // Main content
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),

                    // Progress bar
                    _buildProgressBar(),

                    const SizedBox(height: 70),

                    // Description section
                    _buildDescriptionSection(),

                    const SizedBox(height: 24),

                    // Speakers grid
                    Expanded(child: _buildSpeakersGrid()),
                  ],
                ),
              ),

              // Black gradient overlay behind button
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 80,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black87,
                        Colors.black,
                      ],
                      stops: [0.0, 0.4, 1.0],
                    ),
                  ),
                ),
              ),

              // Continue button positioned at bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  child: _buildContinueButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: List.generate(4, (index) {
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(right: index < 3 ? 16 : 0),
                  decoration: BoxDecoration(
                    color: index == 0 ? Colors.white : const Color(0xFF353333),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(width: 24),
        const Text(
          'Skip',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Find a Church',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFFBFBDBD),
            height: 1.25,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Select speakers that interest you.',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: -0.75,
            height: 1.0,
          ),
        ),
      ],
    );
  }

  Widget _buildSpeakersGrid() {
    // Sample speaker data - you can replace this with actual data from your provider
    final speakers = [
      {'name': 'Levi Lusko', 'image': 'assets/images/speaker1.png'},
      {'name': 'Craig Groeschel', 'image': 'assets/images/speaker2.png'},
      {'name': 'John Piper', 'image': 'assets/images/speaker3.png'},
      {'name': 'Christine Caine', 'image': 'assets/images/speaker4.png'},
      {'name': 'Jackie Hill Perry', 'image': 'assets/images/speaker5.png'},
      {'name': 'Priscilla Shirer', 'image': 'assets/images/speaker6.png'},
      {'name': 'Timothy Keller', 'image': 'assets/images/speaker7.png'},
      {'name': 'John McArthur', 'image': 'assets/images/speaker8.png'},
      {'name': 'Tim Mackie', 'image': 'assets/images/speaker9.png'},
      {'name': 'Francis Chan', 'image': 'assets/images/speaker10.png'},
      {'name': 'Beth Moore', 'image': 'assets/images/speaker11.png'},
      {'name': 'Rick Warren', 'image': 'assets/images/speaker12.png'},
      {'name': 'Derwin Gray', 'image': 'assets/images/speaker13.png'},
      {'name': 'Andy Stanley', 'image': 'assets/images/speaker14.png'},
      {'name': 'Steven Furtick', 'image': 'assets/images/speaker15.png'},
    ];

    // Group speakers into rows of 3
    final List<List<Map<String, String>>> rows = [];
    for (int i = 0; i < speakers.length; i += 3) {
      rows.add(
        speakers.sublist(i, i + 3 > speakers.length ? speakers.length : i + 3),
      );
    }

    return ListView.builder(
      itemCount: rows.length,
      itemBuilder: (context, rowIndex) {
        final row = rows[rowIndex];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: List.generate(3, (colIndex) {
              if (colIndex < row.length) {
                final speaker = row[colIndex];
                return Expanded(
                  child: SizedBox(
                    height: 140,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Invisible placeholder to maintain consistent positioning
                        Container(width: 101, height: 101),
                        // Speaker card centered in the reserved space
                        _buildSpeakerCard(speaker['name']!, speaker['image']!),
                      ],
                    ),
                  ),
                );
              } else {
                return const Expanded(child: SizedBox());
              }
            }),
          ),
        );
      },
    );
  }

  Widget _buildSpeakerCard(String name, String imagePath) {
    return Column(
      children: [
        // Speaker Image Container
        Container(
          width: 101,
          height: 101,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(124),
            border: Border.all(color: Colors.transparent, width: 4),
          ),
          child: Container(
            width: 93,
            height: 93,
            padding: const EdgeInsets.all(4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(76.911),
              child: Container(
                color: const Color(0xFF232121),
                child: const Icon(Icons.person, color: Colors.white, size: 40),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        // Speaker Name
        Text(
          name,
          style: const TextStyle(
            fontFamily: 'Aktiv Grotesk App',
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            height: 1.25,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          if (widget.onNext != null) {
            widget.onNext!();
          } else {
            context.go('/home');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEDEBEB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48),
          ),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(
            color: Color(0xFF121212),
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Aktiv Grotesk App',
          ),
        ),
      ),
    );
  }
}
