import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:ntuaflix/shared/blocs/auth/auth_bloc.dart';
import 'package:ntuaflix/shared/components/animated_expansion.dart';
import 'package:ntuaflix/shared/components/button.dart';
import 'package:ntuaflix/shared/components/default_view.dart';
import 'package:ntuaflix/shared/components/form/bloc/form_state_bloc.dart';
import 'package:ntuaflix/shared/components/form/form.dart';
import 'package:ntuaflix/shared/components/form/form_fields.dart';
import 'package:ntuaflix/shared/extensions/animation_extension.dart';
import 'package:ntuaflix/shared/extensions/form_extension.dart';
import 'package:ntuaflix/shared/extensions/read_or_null_extension.dart';
import 'package:ntuaflix/shared/extensions/size_extension.dart';
import 'package:ntuaflix/shared/extensions/theme_extenstion.dart';
import 'package:ntuaflix/shared/responsive.dart';
import 'package:ntuaflix/views/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String route = "/login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late PageController _pageController;
  late Timer _timer;
  final Duration _dur = const Duration(seconds: 20);
  final List<String> imagePaths = [
    'assets/images/movies_wall.jpg',
    'assets/images/movies_wall.jpg',
  ];
  bool isLogin = true;

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    Future.delayed(
      Duration.zero,
      () {
        _pageController.nextPage(
          duration: _dur,
          curve: Curves.linear,
        );
      },
    );
    _timer = Timer.periodic(_dur, (timer) {
      if (_pageController.page == imagePaths.length - 1) {
        _pageController.jumpToPage(0);
      } else {
        _pageController.nextPage(
          duration: _dur,
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDefaultView(
        canGoBack: false,
        body: LayoutBuilder(builder: (context, constraints) {
          var halfSize = (constraints.maxWidth * .5);
          bool isDisplayOverlay =
              context.responsiveSize != AppResizableSize.DESKTOP;

          /// Form widget
          var formWidget = Container(
            padding: isDisplayOverlay
                ? const EdgeInsets.all(32)
                : const EdgeInsets.only(right: 100),
            decoration: BoxDecoration(
                color: context.theme.appColors.background
                    .withOpacity(isDisplayOverlay ? 0.92 : 1),
                boxShadow: [
                  if (!isDisplayOverlay)
                    BoxShadow(
                      color: context.theme.appColors.background,
                      spreadRadius: 200,
                      blurRadius: 100,
                    )
                ]),
            width: isDisplayOverlay ? constraints.maxWidth : halfSize,
            child: Center(
              child: AppFormBuilder(
                formKey: formKey,
                child: (appFormState) => ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        children: [
                          buildSwitchButton(
                              context,
                              appFormState.stage !=
                                          const AppFormStateStageLoading() &&
                                      !isLogin
                                  ? () {
                                      setState(() {
                                        isLogin = true;
                                      });
                                      formKey.currentState?.fields['email']
                                          ?.didChange(formKey.currentState
                                              ?.fields['email']?.value);
                                    }
                                  : null,
                              "Log in",
                              isLogin),
                          const SizedBox(
                            width: 10,
                          ),
                          buildSwitchButton(
                              context,
                              appFormState.stage !=
                                          const AppFormStateStageLoading() &&
                                      isLogin
                                  ? () {
                                      setState(() {
                                        isLogin = false;
                                      });
                                      Future.delayed(
                                        const Duration(milliseconds: 10),
                                        () {
                                          formKey.currentState!.fields['name']
                                              ?.reset();
                                        },
                                      );
                                    }
                                  : null,
                              "Register",
                              !isLogin),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppAnimatedExpansion(
                          isOpened: !isLogin,
                          child: AppTextField(
                            name: "name",
                            label: "Nickname",
                            expands: false,
                            prefixIcon: const Icon(Icons.person_outline),
                            validator: (string) => !isLogin
                                ? InputValidators.isNotNull(string)
                                : null,
                          )),
                      AppTextField(
                        name: "email",
                        label: "E-mail",
                        prefixIcon: const Icon(Icons.email_outlined),
                        validator: (string) =>
                            InputValidators.isValidEmail(string),
                      ),
                      AppTextField(
                        name: "password",
                        label: "Password",
                        prefixIcon: const Icon(Icons.key_outlined),
                        obscureText: true,
                        validator: (string) =>
                            InputValidators.isNotNull(string) ??
                            InputValidators.minLength(string, 8),
                      ),
                      Center(
                        child: AppButton(
                          text: "Submit",
                          onPressed: () {
                            formKey.setLoading();
                            var values = formKey.getValues;
                            if (isLogin) {
                              context.readOrNull<AuthBloc>()?.add(Login(
                                    email: values?["email"],
                                    password: values?["password"],
                                    onSuccess: () {
                                      formKey.setSuccess(
                                        onSuccess: () {
                                          context.goNamed(HomePage.route);
                                        },
                                      );
                                    },
                                    onError: (_) {
                                      formKey.setError();
                                    },
                                  ));
                            } else {
                              context.readOrNull<AuthBloc>()?.add(Register(
                                    nickname: values?["name"],
                                    email: values?["email"],
                                    password: values?["password"],
                                    formKey: formKey,
                                    onSuccess: () {
                                      formKey.setSuccess(
                                        onSuccess: () {
                                          setState(() {
                                            isLogin = true;
                                          });
                                        },
                                      );
                                    },
                                    onError: (value) {
                                      formKey.setError();
                                    },
                                  ));
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );

          /// Movies
          var moviesWidget = SizedBox(
            width: isDisplayOverlay ? constraints.maxWidth : halfSize,
            child: IgnorePointer(
              ignoring: true,
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final imagePath = imagePaths[index % imagePaths.length];
                  return Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height,
                  );
                },
              ),
            ),
          );
          // return Container();
          return Stack(
            children: [
              moviesWidget,
              Align(alignment: Alignment.centerRight, child: formWidget),
            ],
          );
        }));
  }

  Widget buildSwitchButton(BuildContext context, void Function()? onPressed,
      String text, bool isEnabled) {
    return AnimatedContainer(
      duration: context.defaultAnimationDuration,
      padding: const EdgeInsets.only(right: 8, bottom: 3),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 2,
                  color: isEnabled
                      ? context.theme.appColors.primary
                      : Colors.transparent))),
      child: TextButton(
          style: const ButtonStyle(
              overlayColor: MaterialStatePropertyAll(Colors.transparent),
              padding: MaterialStatePropertyAll(EdgeInsets.zero)),
          onPressed: onPressed,
          child: AnimatedDefaultTextStyle(
            duration: context.defaultAnimationDuration,
            style: context.theme.appTypos.title.copyWith(
                color: context.theme.appColors.text
                    .withOpacity(isEnabled ? 1 : 0.6)),
            child: Text(
              text,
            ),
          )),
    );
  }
}
