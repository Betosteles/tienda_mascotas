import 'package:flutter/material.dart';

class WidgetMenuPerfil extends StatelessWidget {
  const WidgetMenuPerfil({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyLarge?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.arrow_right,
                color: Colors.grey,
              ),
            )
          : null,
    );
  }
}
