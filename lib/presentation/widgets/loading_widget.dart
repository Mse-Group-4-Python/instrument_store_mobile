import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  final String title;
  const LoadingWidget({
    super.key,
    this.title = 'Loading...',
  });

  @override
  Widget build(BuildContext context) {
    return FadeInAnimation(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: (context.mediaQuery.size.height * .8).clamp(0, 400),
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Lottie.asset(
                  'assets/loading_animation.json',
                  height: 200,
                  width: 200,
                ),
              ),
              const SizedBox(height: 20),
              AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    title,
                    speed: const Duration(milliseconds: 210),
                    textStyle: context.theme.textTheme.headlineSmall?.copyWith(
                      color: context.theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                repeatForever: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
