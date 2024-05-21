import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    required this.onTap,
    required this.splashColor,
    required this.icon,
    required this.color,
  });

  final void Function() onTap;
  final Color splashColor;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        splashColor: splashColor,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            icon,
            color: color,
          ),
        ),
      ),
    );
  }
}
