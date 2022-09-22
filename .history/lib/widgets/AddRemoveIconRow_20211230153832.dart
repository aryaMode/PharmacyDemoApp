  class AddRemoveIconRow
   extends StatelessWidget {
    const AddRemoveIconRow
    ({Key? key}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return Container();
    }
  }
  class AddRemoveIconRow({
    dynamic Function()? onAdd,
    dynamic Function()? onDelete,
    double inheritedPadding = 0,
    required int listLength,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedIconButton(
            inheritedPadding: inheritedPadding,
            icon: Icons.remove,
            active: listLength != 1,
            onPressed: onDelete),
        ElevatedIconButton(
            inheritedPadding: inheritedPadding,
            icon: Icons.add,
            active: true,
            onPressed: onDelete),
      ],
    );
  }