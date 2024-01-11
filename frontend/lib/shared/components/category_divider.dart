import 'package:flutter/material.dart';
import 'package:ntuaflix/shared/extensions/theme_extenstion.dart';

class CategoryDivider extends StatelessWidget {
  const CategoryDivider({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10, top: 30),
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: context.theme.appColors.primary, width: 3))),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              text,
              style: context.theme.appTypos.body.copyWith(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
