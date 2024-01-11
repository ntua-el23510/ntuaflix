import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ntuaflix/shared/extensions/string_extension.dart';
import 'package:ntuaflix/shared/extensions/theme_extenstion.dart';
import 'package:ntuaflix/shared/models/principal.dart';

class PrincipalTile extends StatelessWidget {
  final Principal principal;
  final int index;
  final bool actionEnabled;
  const PrincipalTile(
      {super.key,
      required this.principal,
      required this.index,
      this.actionEnabled = true});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: actionEnabled ? 160 : 200),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 5 / 7,
                child: Hero(
                  tag: "Principal:${principal.nconst}",
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 50,
                              spreadRadius: 10,
                              offset: const Offset(5, 5))
                        ],
                        borderRadius: BorderRadius.circular(18),
                        image: (principal.person?.imgUrlAsset ??
                                    principal.imgUrlAsset) !=
                                null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage((principal
                                            .person?.imgUrlAsset ??
                                        principal.imgUrlAsset)!
                                    .replaceAll("{width_variable}", "w500")))
                            : const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/images/placeholder.png"))),
                    child: actionEnabled
                        ? TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                )),
                                padding: const MaterialStatePropertyAll(
                                    EdgeInsets.zero)),
                            onPressed: () {},
                            child: const SizedBox.shrink(),
                          )
                        : null,
                  ),
                ),
              ),
              if (actionEnabled) ...[
                Material(
                  type: MaterialType.transparency,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Column(
                      children: [
                        Text(
                          principal.person?.primaryName ?? "",
                          style: context.theme.appTypos.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                        Text(
                          principal.category.capitalize(),
                          style: context.theme.appTypos.title.copyWith(
                              fontSize: 15, fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                )
              ]
            ],
          ),
        ),
      ).animate().fadeIn(delay: 100.ms * index);
    });
  }
}
