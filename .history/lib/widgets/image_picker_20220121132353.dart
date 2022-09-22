import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/utils/helper/firebase_storage_helper.dart';
import 'package:demo_catalog_app/utils/helper/image_helper.dart';
import 'package:demo_catalog_app/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class ImagePicker extends StatefulWidget {
  final VoidCallback? onTap;
  Img? image;
  ImagePicker({Key? key, this.image, this.onTap}) : super(key: key);

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        html.File? testImage = await pickWebImage();
        if (testImage != null) {
          String url = await uploadWebImage(testImage);
          if (widget.image != null && widget.image!.url != null) {
            await removeWebImage(widget.image!.url!);
          }
          setState(() {
            widget.image = ImageWidget(image: Img(url: url));
          });
        }
      },
      child: ImageWidget(widget.image ??
          ImageWidget(
            image: Img(),
          ),
    );
  }
}
