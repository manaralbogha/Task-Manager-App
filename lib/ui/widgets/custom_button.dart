import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/helpers/app_colors.dart';
import 'package:task_manager_app/ui/helpers/size_config.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final double? width;
  final String text;
  final double? borderRadius;
  final Color? color;
  final double? height;
  final double? fontSize;
  const CustomButton({
    super.key,
    this.onTap,
    this.width,
    required this.text,
    this.borderRadius,
    this.color,
    this.height,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? AppColors.defaultColor,
      borderRadius: BorderRadius.circular(borderRadius ?? 25),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius ?? 25),
        onTap: onTap,
        child: SizedBox(
          width: width ?? SizeConfig.screenWidth,
          height: height ?? SizeConfig.defaultSize * 5,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize ?? SizeConfig.defaultSize * 2,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
