import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ntuaflix/shared/blocs/auth/auth_bloc.dart';
import 'package:ntuaflix/shared/components/animated_expansion.dart';
import 'package:ntuaflix/shared/components/button.dart';
import 'package:ntuaflix/shared/components/form/form_fields.dart';
import 'package:ntuaflix/shared/extensions/read_or_null_extension.dart';
import 'package:ntuaflix/shared/extensions/size_extension.dart';
import 'package:ntuaflix/shared/extensions/theme_extenstion.dart';
import 'package:ntuaflix/shared/icons.dart';
import 'package:ntuaflix/shared/responsive.dart';
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
    var isInColumn = context.responsiveSize != AppResizableSize.DESKTOP;
    return Scaffold(
        backgroundColor: context.theme.appColors.background,
        appBar: AppBar(
          toolbarHeight: switch (context.responsiveSize) {
            AppResizableSize.DESKTOP => 65,
            AppResizableSize.TABLET => 150,
            AppResizableSize.MOBILE => 200,
          },
          leadingWidth: 40,
          leading: !context.canPop() || !canGoBack
              ? Container(
                  width: 40,
                )
              : null,
          backgroundColor: context.theme.appColors.secondary,
          title: Builder(builder: (context) {
            var children = [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                    onTap: () {
                      context.goNamed(HomePage.route);
                    },
                    child: SvgPicture.asset(CustomIcons.logo, height: 30)),
              ),
              const SizedBox(
                width: 10,
                height: 10,
              ),
              Flexible(
                  flex: isInColumn ? 0 : 1,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: context.responsiveSize == AppResizableSize.DESKTOP
                            ? 20.0
                            : 0),
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
                    ),
                  )),
              const SizedBox(
                width: 10,
                height: 10,
              ),
              Flexible(
                flex: isInColumn ? 0 : 1,
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppAnimatedExpansion(
                            isOpened: state.user != null,
                            child: Text(
                              state.user?.name ?? "",
                              style: context.theme.appTypos.body,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        AppButton(
                          buttonType: AppButtonType.ButtonInverted,
                          customIcon: CustomIcons.login,
                          iconOnRight: true,
                          text: state.runtimeType == Authorized
                              ? "Logout"
                              : "Login",
                          onPressed: () {
                            if (state.runtimeType == Authorized) {
                              context.readOrNull<AuthBloc>()?.add(Logout());
                            } else {
                              context.goNamed(LoginPage.route);
                            }
                          },
                        )
                      ],
                    );
                  },
                ),
              )
            ];
            return isInColumn
                ? Padding(
                    padding: const EdgeInsets.only(right: 56.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: children),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: children,
                  );
          }),
        ),
        body: body);
  }
}
