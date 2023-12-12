import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading(
      {super.key,
      this.isDarkMode,
      this.isItForWidget = false,
      this.isItBtn = false,
      this.color = Colors.white});
  final bool? isDarkMode;
  final bool? isItForWidget, isItBtn;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (isItForWidget!) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 1,
          // color: color ?? kPrimaryColor,
        ),
      );
    }
    if (isItBtn!) {
      return Center(
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: const Padding(
            padding: EdgeInsets.all(5.0),
            child: CircularProgressIndicator(
              strokeWidth: 1,
              //color: kWhiteColor,
              //backgroundColor: kPrimaryColor,
            ),
          ),
        ),
      );
    }

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 1,
          //color: Colors.white,
        ),
      ),
    );
  }
}
