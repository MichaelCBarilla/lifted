import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifted/src/common_widgets/alert_dialogs.dart';
import 'package:lifted/src/localization/string_hardcoded.dart';

extension AsyncValueUi on AsyncValue {
  void showAlertDialogError(BuildContext context) {
    if (!isLoading && hasError) {
      showExceptionAlertDialog(
        context: context,
        title: 'Error'.hardcoded,
        exception: error,
      );
    }
  }
}
