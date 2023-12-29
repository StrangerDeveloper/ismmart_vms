import 'package:flutter/material.dart';
import 'package:ismmart_vms/helper/theme_helper.dart';

import '../helper/constants.dart';

//FINAL VERSION...
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
    this.height = 40,
    this.title = "",
    this.width = double.infinity,
    required this.onPressed,
    this.backgroundColor = ThemeHelper.blue1,
    this.foregroundColor = Colors.white,
    this.child,
    this.radius = 8,
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
      child: child ??
          Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
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
    this.height = 40,
    this.title = "",
    this.width = double.infinity,
    required this.onPressed,
    this.backgroundColor = newColorBlue,
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
    return ElevatedButton(
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
                borderRadius: BorderRadius.circular(borderRadius),
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

//FINAL VERSION...
class CustomIconTextBtn extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;
  final double width;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final MaterialTapTargetSize? tapTargetSize;
  final OutlinedBorder? shape;
  final BorderSide borderSide;
  final IconData icon;

  const CustomIconTextBtn({
    super.key,
    this.height = 40,
    required this.title,
    this.width = double.infinity,
    required this.onPressed,
    this.backgroundColor = ThemeHelper.blue1,
    this.foregroundColor = Colors.white,
    this.radius = 10,
    this.padding,
    this.tapTargetSize,
    this.borderSide = BorderSide.none,
    this.shape,
    required this.icon,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

//FINAL VERSION...
class CustomIconBtn extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final double? iconSize;
  final void Function()? onTap;

  const CustomIconBtn({
    super.key,
    this.iconSize,
    this.enabled = true,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Icon(
                icon,
                color: enabled ? null : Colors.grey.shade400,
                size: iconSize ?? 15,
              )
      ),
    );
  }
}

//FINAL VERSION...
class CustomIconBtn2 extends StatelessWidget {
  final IconData icon;
  final void Function()? onTap;
  final Color? color;

  const CustomIconBtn2({
    super.key,
    required this.icon,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, size: 15, color: color ?? Colors.black),
      ),
    );
  }
}
