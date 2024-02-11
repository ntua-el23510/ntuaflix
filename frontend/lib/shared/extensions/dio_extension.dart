import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ntuaflix/shared/logger.dart';

extension DioExceptionExtension on DioException {
  void showFormErrors(GlobalKey<FormBuilderState>? formKey) {
    var responseData = response?.data as Map<String, dynamic>?;
    if (responseData != null && responseData["errors"] != null) {
      var errors = responseData["errors"] as Map<String, dynamic>?;
      AppLogger.log([Colors.red, "Form errors:"], error: true);
      errors?.forEach((key, value) {
        value as List<dynamic>;
        AppLogger.log([Colors.red, "\t$key => $value"]);
        var errorText = value.firstOrNull;
        if (errorText != null) {
          formKey?.currentState?.fields[key]?.invalidate(errorText);
        }
      });
    }
  }
}
