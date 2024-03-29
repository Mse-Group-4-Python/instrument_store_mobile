import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorHandleWidget extends StatelessWidget {
  final String title;
  final String content;
  final Function()? onRetry;
  const ErrorHandleWidget({
    super.key,
    this.title = 'Oh no, something went wrong',
    this.content = '',
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: Center(
        child: Column(
          children: [
            Lottie.asset(
              'assets/empty_animation.json',
              width: 200,
              height: 200,
            ),
            Text(title),
            const SizedBox(height: 8),
            Text(content),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
