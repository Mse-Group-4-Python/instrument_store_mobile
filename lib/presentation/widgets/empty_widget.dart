import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class EmptyHandleWidget extends StatelessWidget {
  final String title;
  final String content;
  final Function()? onRetry;
  const EmptyHandleWidget({
    super.key,
    this.title = 'Không có dữ liệu',
    this.content = '',
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(64),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primaryContainer.withOpacity(.1),
        shape: BoxShape.circle,
      ),
      child: Column(
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
              child: const Text('Thử lại'),
            ),
          ],
        ],
      ),
    );
  }
}
