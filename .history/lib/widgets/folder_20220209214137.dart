import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/image_paths.dart';
import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:demo_catalog_app/widgets/elevated_icon_button.dart';
import 'package:demo_catalog_app/widgets/image_widget.dart';

import 'text_widget.dart';

class Folder extends ConsumerWidget {
  final Img? backgroundImage;
  final String? text;
  final bool? editable;
  final Color textColor;
  final void Function(String)? onFieldSubmitted;
  final VoidCallback? onPress;
  const Folder({
    Key? key,
    this.editable,
    this.backgroundImage,
    this.text,
    this.onFieldSubmitted,
    this.textColor = Colors.black,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool editable = this.editable ?? ref.watch(editableProvider);
    return GestureDetector(
      onTap: onPress,
      child: Card(
        elevation: 8.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          children: <Widget>[
            ImageWidget(
              fit: BoxFit.cover,
              opacity: editable ? 0.2 : 0.4,
              image:
                  backgroundImage ?? Img(assetPath: kDefaultFolderBackground),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(kDefaultPadding),
              child: TextWidget(
                editable: editable,
                text: text ?? "Untitled",
                onSubmitted: onFieldSubmitted,
                textStyle: TextStyle(
                  fontSize: 20,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            editable
                ? Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.only(top: kDefaultPadding / 2),
                      child: ElevatedIconButton(
                        inheritedPadding: kDefaultPadding / 2,
                        icon: Icons.image_rounded,
                        iconColor: kSecondaryColor,
                        backgroundColor: kPrimaryColor,
                        onPressed: onBackgroundIconPressed,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Folder copyWith({
    Img? backgroundImage,
    String? text,
    bool? editable,
    Color? textColor,
    void Function(String)? onFieldSubmitted,
    VoidCallback? onPress,
  }) {
    return Folder(
      backgroundImage: backgroundImage ?? this.backgroundImage,
      text: text ?? this.text,
      editable: editable ?? this.editable,
      textColor: textColor ?? this.textColor,
      onFieldSubmitted: onFieldSubmitted ?? this.onFieldSubmitted,
      onPress: onPress ?? this.onPress,
    );
  }
}
