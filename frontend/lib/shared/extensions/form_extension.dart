import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ntuaflix/shared/components/form/bloc/form_state_bloc.dart';
import 'package:ntuaflix/shared/extensions/read_or_null_extension.dart';

extension FormBuilderExtension on GlobalKey<FormBuilderState> {
  Map<String, dynamic>? get getValues => currentState?.instantValue;
  void setLoading() {
    currentState?.context
        .readOrNull<AppFormStateBloc>()
        ?.add(AppFormStageChanged(const AppFormStateStageLoading()));
  }

  void setSuccess({VoidCallback? onSuccess}) {
    currentState?.context.readOrNull<AppFormStateBloc>()?.add(
        AppFormStageChanged(AppFormStateStageSuccess(onFinished: onSuccess)));
  }

  void setError({VoidCallback? onError}) {
    currentState?.context
        .readOrNull<AppFormStateBloc>()
        ?.add(AppFormStageChanged(AppFormStateStageError(onFinished: onError)));
  }

  void setNormal() {
    currentState?.context
        .readOrNull<AppFormStateBloc>()
        ?.add(AppFormStageChanged(const AppFormStateStageNormal()));
  }

  void reset() {
    currentState?.reset();
  }
}
