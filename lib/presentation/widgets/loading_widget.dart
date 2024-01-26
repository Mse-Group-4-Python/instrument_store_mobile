import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingWidget extends StatelessWidget {
  final String title;
  const LoadingWidget({
    super.key,
    this.title = 'Loading...',
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: (context.mediaQuery.size.height * .8).clamp(0, 400),
      ),
      child: Center(
        child: Column(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 12),
            Text(title),
          ],
        ),
      ),
    );
  }
}
