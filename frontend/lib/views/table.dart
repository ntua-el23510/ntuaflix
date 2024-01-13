import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ntuaflix/shared/extensions/theme_extenstion.dart';

class TableTitle extends StatelessWidget {
  const TableTitle({super.key, required this.title, required this.index});

  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return TableCell(
        child: Padding(
      padding: const EdgeInsets.only(top: 5, right: 10),
      child: Text(
        "$title:",
        style:
            context.theme.appTypos.body.copyWith(fontWeight: FontWeight.normal),
        textAlign: TextAlign.start,
        maxLines: 2,
      )
          .animate()
          .fadeIn(duration: 500.ms, delay: (200 + index * 100).ms)
          .slideY(
              delay: (200 + index * 100).ms,
              begin: 2,
              duration: 400.ms,
              curve: Curves.easeOutBack),
    ));
  }
}

class TableBody extends StatelessWidget {
  const TableBody({super.key, required this.text, required this.index});

  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    return TableCell(
        child: Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        text,
        style: context.theme.appTypos.body,
        textAlign: TextAlign.start,
        maxLines: 2,
      )
          .animate()
          .fadeIn(duration: 500.ms, delay: (300 + index * 100).ms)
          .slideY(
              delay: (300 + index * 100).ms,
              begin: 2,
              duration: 400.ms,
              curve: Curves.easeOutBack),
    ));
  }
}
