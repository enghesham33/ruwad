import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTag extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final bool showBorder;

  const CustomTag({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        // margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            border: showBorder ? Border.all(
              color: borderColor ?? Theme.of(context).textTheme.bodySmall!.color!,
              width: 1.5,
            ) : null,
            borderRadius: BorderRadius.circular(16),
          color: backgroundColor ?? Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            text,
            style: foregroundColor == null
                ? Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    )
                : Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.bold,
                      color: foregroundColor,
                    ),
          ),
        ),
      ),
    );
  }
}
