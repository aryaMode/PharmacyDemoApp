import 'package:demo_catalog_app/constants/colors.dart';
import 'package:flutter/material.dart';

// class ElevatedIconButton extends StatelessWidget {
//   final IconData icon;
//   final Function()? onPressed;
//   final double inheritedPadding;
//   final Color? iconColor, backgroundColor;
//   final bool active;
//   const ElevatedIconButton({
//     Key? key,
//     required this.icon,
//     this.onPressed,
//     this.iconColor = Colors.white,
//     this.active = true,
//     this.inheritedPadding = 0,
//     this.backgroundColor = kSecondaryColor,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: inheritedPadding),
//         child: Icon(
//           icon,
//           color: active ? iconColor : Colors.grey,
//         ),
//       ),
//       style: ElevatedButton.styleFrom(
//         shape: CircleBorder(),
//         elevation: active ? 6 : 0,
//         primary: active ? backgroundColor : Colors.grey.shade800,
//       ),
//     );
//   }
// }

class ElevatedIconButton extends StatelessWidget {
  final IconData icon;
  final Function()? onPressed;
  final double inheritedPadding;
  final Color? iconColor, backgroundColor;
  final bool active;
  const ElevatedIconButton({
    Key? key,
    required this.icon,
    this.onPressed,
    this.iconColor = Colors.white,
    this.active = true,
    this.inheritedPadding = 0,
    this.backgroundColor = kSecondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: Text("label"),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: active ? iconColor : Colors.grey,
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        elevation: active ? 6 : 0,
        primary: active ? backgroundColor : Colors.grey.shade800,
      ),
    );
  }
}
