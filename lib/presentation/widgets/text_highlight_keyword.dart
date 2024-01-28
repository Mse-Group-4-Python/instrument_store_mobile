import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instrument_store_mobile/core/utils/string_ext.dart';

class TextHighlightKeyword extends StatelessWidget {
  final String text;
  final String? keyword;
  final TextStyle? basicStyle;
  const TextHighlightKeyword({
    required this.text,
    required this.keyword,
    required this.basicStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (keyword == null || keyword!.isEmpty) {
      return Text(text, style: basicStyle);
    }
    return RichText(
      text: TextSpan(
        children: text.splitByKeyword(keyword!.trim()).map((e) {
          final isKeyword = e.removeDiacritics().toLowerCase() ==
              keyword?.toLowerCase().removeDiacritics();
          if (isKeyword) {
            return TextSpan(
              text: e,
              style: basicStyle?.copyWith(
                color: context.theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            );
          }
          return TextSpan(text: e, style: basicStyle);
        }).toList(),
      ),
    );
  }
}
