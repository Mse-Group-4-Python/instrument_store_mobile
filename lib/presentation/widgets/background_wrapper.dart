import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackgroundWrapper extends StatelessWidget {
  final Widget child;
  const BackgroundWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.mediaQuery.size.width,
      height: context.mediaQuery.size.height,
      child: Stack(
        children: [
          Positioned(
            left: -170,
            top: -80,
            child: Container(
              width: context.mediaQuery.size.width,
              height: context.mediaQuery.size.height * .4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.teal.shade100,
                    context.theme.colorScheme.surface,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Positioned(
            right: -170,
            bottom: -170,
            child: Container(
              width: context.mediaQuery.size.width,
              height: context.mediaQuery.size.height * .4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.teal.shade100,
                    context.theme.colorScheme.surface,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
