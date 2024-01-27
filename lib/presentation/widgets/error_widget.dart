import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

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
            Text(title),
            Text(content),
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
