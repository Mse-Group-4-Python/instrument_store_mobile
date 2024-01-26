import 'package:flutter/material.dart';

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
