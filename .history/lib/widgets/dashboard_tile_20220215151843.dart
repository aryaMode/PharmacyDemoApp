import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:flutter/material.dart';

class DashboardTile extends StatefulWidget {
  final String title;
  final void Function()? onPressed;

  DashboardTile({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<DashboardTile> createState() => _DashboardTileState();
}

class _DashboardTileState extends State<DashboardTile> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      onHover: (isHovering) {
        setState(() {
          hovering = isHovering;
        });
      },
      hoverColor: Colors.transparent,
      splashColor: Colors.black.withOpacity(0.2),
      highlightColor: Colors.transparent,
      child: Container(
        height: (173) * 2,
        width: (305) * 2,
        margin: EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          color: kSecondaryColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: hovering == false ? Colors.transparent : Colors.black12,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }
}
