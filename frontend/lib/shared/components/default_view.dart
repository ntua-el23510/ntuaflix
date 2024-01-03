import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ntuaflix/shared/components/button.dart';
import 'package:ntuaflix/shared/components/form/form_fields.dart';
import 'package:ntuaflix/shared/extensions/theme_extenstion.dart';
import 'package:ntuaflix/shared/icons.dart';
import 'package:ntuaflix/views/details_page.dart';
import 'package:ntuaflix/views/home_page.dart';
import 'package:ntuaflix/views/login_page.dart';

class AppDefaultView extends StatelessWidget {
  const AppDefaultView(
      {super.key,
      required this.body,
      this.displaySearchbox = true,
      this.canGoBack = true});

  final bool canGoBack;
  final bool displaySearchbox;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.appColors.background,
        appBar: AppBar(
          toolbarHeight: 65,
          leadingWidth: 56,
          leading: !context.canPop() || !canGoBack
              ? Container(
                  width: 56,
                )
              : null,
          backgroundColor: context.theme.appColors.secondary,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                      onTap: () {
                        context.goNamed(HomePage.route);
                      },
                      child: SvgPicture.asset(CustomIcons.logo, height: 30)),
                ),
              ),
              Flexible(
                  flex: 3,
                  child: Visibility(
                    visible: displaySearchbox,
                    child: Hero(
                      tag: "searchbar",
                      child: AppTextField(
                        onTap: () {
                          GoRouter.of(context).goNamed(SearchPage.route);
                        },
                        readOnly: true,
                        name: "searchbar",
                        label: "Search for films, actors",
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 20,
                        ),
                      ),
                    ),
                  )),
              Flexible(
                flex: 1,
                child: Wrap(
                  spacing: 5,
                  children: [
                    AppButton(
                      buttonType: AppButtonType.ButtonTransparent,
                      text: "Films",
                      onPressed: () {},
                    ),
                    AppButton(
                      buttonType: AppButtonType.ButtonTransparent,
                      text: "Ranking",
                      onPressed: () {},
                    ),
                    AppButton(
                      buttonType: AppButtonType.ButtonInverted,
                      customIcon: CustomIcons.login,
                      iconOnRight: true,
                      text: "Login",
                      onPressed: () {
                        context.goNamed(LoginPage.route);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: body);
  }
}
