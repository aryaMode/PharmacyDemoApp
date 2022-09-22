import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextWidget extends ConsumerWidget {
  final void Function(String p1)? onFieldSubmitted;
  final String text;
  final double? fontSize;
  final TextStyle? textStyle;
  final bool? editable;

  const TextWidget({
    Key? key,
    this.editable,
    this.onFieldSubmitted,
    required this.text,
    this.fontSize,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editable = this.editable ?? ref.watch(editableProvider);
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: IntrinsicWidth(
        child: TextField(
          minLines: 1,
          maxLines: 2,
          onSubmitted: onFieldSubmitted,
          // onFieldSubmitted: onFieldSubmitted,
          textAlign: TextAlign.center,

          // initialValue: text,
          decoration: InputDecoration(
            isCollapsed: true,
            border: InputBorder.none,
          ),
          readOnly: ?editable,
          style: textStyle,
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
      textStyle: textStyle ?? this.textStyle,
    );
  }
}
