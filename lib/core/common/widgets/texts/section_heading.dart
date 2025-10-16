import 'package:breads/core/constants/app_strings.dart';
import 'package:flutter/material.dart';


class SectionHeading extends StatelessWidget {
  final bool isActionButton, isIcon;
  final String text, buttonText;
  final Color? textColor, iconColor, textActionColor;
  final double? fontSize;
  final void Function()? onPressed;
  final IconData? icon;
  const SectionHeading(
      {super.key,
      this.isActionButton = true,
      required this.text,
      this.buttonText = AppStrings.seeAll,
      this.textColor,
      this.fontSize,
      this.textActionColor,
      this.onPressed,
      this.isIcon = false,
      this.icon,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (isActionButton)
          TextButton(
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: TextStyle(color: textActionColor, fontSize: fontSize),
              )),
        if (isIcon)
          IconButton(
              onPressed: onPressed,
              icon: Icon(
                icon,
                color: iconColor,
              )),
      ],
    );
  }
}