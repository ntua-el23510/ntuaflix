import 'package:flutter/material.dart';
import 'package:ntuaflix/shared/responsive.dart';

extension AppResponsive on BuildContext {
  AppResizableSize get responsiveSize => AppResizable.size(this);
}
