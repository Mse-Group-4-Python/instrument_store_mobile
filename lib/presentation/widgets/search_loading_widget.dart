import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SearchLoadingWidget extends StatelessWidget {
  final String text;
  const SearchLoadingWidget({
    Key? key,
    this.text = 'Searching...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.surfaceVariant.withOpacity(.1),
            shape: BoxShape.circle,
          ),
          child: Lottie.asset(
            'assets/search_animation.json',
          ),
        ),
        const SizedBox(height: 20),
        AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText(
              text,
              speed: const Duration(milliseconds: 210),
              textStyle: context.theme.textTheme.titleLarge?.copyWith(
                color: context.theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          repeatForever: true,
        ),
      ],
    );
  }
}
