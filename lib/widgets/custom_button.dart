import 'package:flutter/material.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';

import '../helper/constants.dart';

class CustomTextBtn extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;
  final double width;
  final Widget? child;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final MaterialTapTargetSize? tapTargetSize;
  final OutlinedBorder? shape;
  final BorderSide borderSide;

  const CustomTextBtn({
    super.key,
    this.height = 44,
    this.title = "",
    this.width = double.infinity,
    required this.onPressed,
    this.backgroundColor = ThemeHelper.primary,
    this.foregroundColor = Colors.white,
    this.child,
    this.radius = 6,
    this.padding,
    this.tapTargetSize,
    this.borderSide = BorderSide.none,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding,
        tapTargetSize: tapTargetSize,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: Size(width, height),
        side: borderSide,
        shape: (shape != null)
            ? shape
            : RoundedRectangleBorder(
                side: borderSide,
                borderRadius: BorderRadius.circular(radius),
              ),
      ),
      child: child ?? Text(title),
    );
  }
}

class CustomRoundedTextBtn extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;
  final double width;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final MaterialTapTargetSize? tapTargetSize;
  final OutlinedBorder? shape;
  final BorderSide borderSide;
  final double borderRadius;

  const CustomRoundedTextBtn({
    super.key,
    this.height = 50,
    this.title = "",
    this.width = double.infinity,
    required this.onPressed,
    this.backgroundColor = ThemeHelper.primary,
    this.foregroundColor = Colors.white,
    this.child,
    this.padding,
    this.borderRadius = 30,
    this.tapTargetSize,
    this.borderSide = BorderSide.none,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding,
        tapTargetSize: tapTargetSize,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: Size(width, height),
        side: borderSide,
        shape: (shape != null)
            ? shape
            : RoundedRectangleBorder(
                side: borderSide,
                borderRadius: BorderRadius.circular(borderRadius ?? 30),
              ),
      ),
      child: child ?? Text(title),
    );
  }
}

class CustomBackButton extends StatelessWidget {
  final void Function() onTap;

  const CustomBackButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(-3, 0),
              blurRadius: 2,
              spreadRadius: 1,
            )
          ],
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 15,
        ),
      ),
    );
  }
}

class CustomActionIcon extends StatelessWidget {
  const CustomActionIcon({
    super.key,
    this.bgColor,
    this.iconColor,
    this.onTap,
    this.icon,
    this.size = 18,
    this.height = 30,
    this.width = 30,
    this.hasShadow = true,
  });

  final Color? bgColor, iconColor;
  final GestureTapCallback? onTap;
  final IconData? icon;
  final double? size, height, width;
  final bool? hasShadow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: bgColor == null
            ? null
            : BoxDecoration(
          color: bgColor ?? Colors.transparent, //?.withOpacity(0.6),
          shape: BoxShape.circle,
          boxShadow: [
            if (hasShadow!)
              BoxShadow(
                color: kDarkColor.withOpacity(0.2),
                offset: Offset(0, 1),
                blurRadius: 10.7,
              )
          ],
        ),
        child: Icon(
          icon,
          size: size,
          color: iconColor ?? Colors.white,
        ),
      ),
    );
  }
}