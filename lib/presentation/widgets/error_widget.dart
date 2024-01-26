import 'package:flutter/material.dart';

class ErrorHandleWidget extends StatelessWidget {
  final String title;
  final String content;
  final Function()? onRetry;
  const ErrorHandleWidget({
    super.key,
    this.title = 'Có lỗi xảy ra',
    this.content = '',
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(title),
          Text(content),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Thử lại'),
          ),
        ],
      ),
    );
  }
}
