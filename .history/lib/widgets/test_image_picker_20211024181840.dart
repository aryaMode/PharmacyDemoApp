// import 'dart:typed_data';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';

// class TestImagePicker extends StatefulWidget {
//   Uint8List imageBytes;
//   bool isPicker;
//   TestImagePicker(
//       {required this.imageBytes, this.isPicker = false, this.fromAddPage = false});
//   bool fromAddPage;

//   @override
//   _TestImagePickerState createState() => _TestImagePickerState();
// }

// class _TestImagePickerState extends State<TestImagePicker> {
//   Future getImage() async {
//     FilePickerResult result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       setState(() {
//         PlatformFile file = result.files.first;
//         widget.imageBytes.data = file.bytes;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Center(
//       child: GestureDetector(
//           onTap: () => widget.isPicker ? getImage() : null,
//           child: SizedBox(
//             height:
//                 widget.fromAddPage || widget.isPicker ? 50 : double.infinity,
//             child: PhotoView(
//               backgroundDecoration: BoxDecoration(
//                 color: Colors.white,
//               ),
//               minScale: PhotoViewComputedScale.contained * 1,
//               maxScale: PhotoViewComputedScale.contained * 1.8,
//               imageProvider: MemoryImage(widget.imageBytes.data == null
//                   ? toImageBytes(kUploadImage)
//                   : widget.imageBytes.data),
//             ),
//           )),
//     ));
//   }
// }
