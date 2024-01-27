import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class EmptyHandleWidget extends StatelessWidget {
  final String title;
  final String content;
  final Function()? onRetry;
  final String retryText;
  const EmptyHandleWidget({
    super.key,
    this.title = 'No data is available',
    this.content = '',
    this.onRetry,
    this.retryText = 'Retry',
  });

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: Container(
        margin: const EdgeInsets.all(32),
        padding: const EdgeInsets.all(64),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.theme.colorScheme.primaryContainer.withOpacity(.1),
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/empty_animation.json',
            ),
            Text(
              title,
              style: context.theme.textTheme.titleMedium?.copyWith(
                color: context.theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (content.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                content,
                style: context.theme.textTheme.bodySmall?.copyWith(
                  color: context.theme.colorScheme.primary,
                ),
              ),
            ],
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onRetry,
                child: Text(retryText),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
