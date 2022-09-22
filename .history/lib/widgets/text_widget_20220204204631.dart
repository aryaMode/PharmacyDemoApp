import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextWidget extends ConsumerWidget {
  final void Function(String)? onSubmitted;
  final String text;
  final double? fontSize;
  final TextStyle? style;
  final bool? editable;
  final String? hintText;

  const TextWidget({
    this.hintText,
    this.editable,
    this.onSubmitted,
    required this.text,
    this.fontSize,
    this.style,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool editable = this.editable ?? ref.watch(editableProvider);
    return FmaittedBox(
      fit: BoxFit.scaleDown,
      child: IntrinsicWidth(
        child: TextField(
          maxLines: 1,
          controller: TextEditingController(text: text),
          onSubmitted: onSubmitted,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: editable ? hintText : "",
            isCollapsed: true,
            border: InputBorder.none,
          ),
          enabled: editable,
          style: style,
        ),
      ),
    );
  }

  TextWidget copyWith({
    void Function(String p1)? onFieldSubmitted,
    String? text,
    double? fontSize,
    TextStyle? textStyle,
    bool? editable,
  }) {
    return TextWidget(
      editable: editable ?? this.editable,
      text: text ?? this.text,
      fontSize: fontSize ?? this.fontSize,
      style: textStyle ?? this.style,
    );
  }
}
