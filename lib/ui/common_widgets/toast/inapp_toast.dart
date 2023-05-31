import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class InAppToast {
  InAppToast._();
  static const _toastPosition = GFToastPosition.BOTTOM;
  static const double _toastRadius = 10;
  static const double _toastIconSize = 20;
  static void otpVerificationSuccess(BuildContext context) {
    GFToast.showToast(
      "OTP verified Successfully",
      context,
      toastPosition: _toastPosition,
      trailing: const Icon(
        Icons.done,
        color: GFColors.SUCCESS,
        size: _toastIconSize,
      ),
      toastBorderRadius: _toastRadius,
    );
  }

  static void errorSendingOtp(BuildContext context) {
    GFToast.showToast(
      "Error occurred sending OTP.\n Try again after some time",
      context,
      toastDuration: 5,
      toastPosition: _toastPosition,
      trailing: const Icon(
        Icons.cancel,
        color: GFColors.DANGER,
        size: _toastIconSize,
      ),
      toastBorderRadius: _toastRadius,
    );
  }

  static void wrongOtp(BuildContext context) {
    GFToast.showToast(
      "Wrong OTP",
      context,
      toastDuration: 5,
      toastPosition: _toastPosition,
      trailing: const Icon(
        Icons.cancel,
        color: GFColors.DANGER,
        size: _toastIconSize,
      ),
      toastBorderRadius: _toastRadius,
    );
  }

  static void otpSendSuccess(BuildContext context) {
    GFToast.showToast(
      "OTP sent Successfully",
      context,
      toastPosition: _toastPosition,
      trailing: const Icon(
        Icons.done,
        color: GFColors.SUCCESS,
        size: _toastIconSize,
      ),
      toastBorderRadius: _toastRadius,
    );
  }

  static void logoutFailed(BuildContext context) {
    GFToast.showToast(
      "Error occurred while logging out",
      context,
      toastDuration: 5,
      toastPosition: _toastPosition,
      trailing: const Icon(
        Icons.cancel,
        color: GFColors.DANGER,
        size: _toastIconSize,
      ),
      toastBorderRadius: _toastRadius,
    );
  }

  static void genericFailureToast(BuildContext context, String text) {
    GFToast.showToast(
      text,
      context,
      toastDuration: 5,
      toastPosition: _toastPosition,
      trailing: const Icon(
        Icons.cancel,
        color: GFColors.DANGER,
        size: _toastIconSize,
      ),
      toastBorderRadius: _toastRadius,
    );
  }

  static void genericSuccessToast(BuildContext context, String text) {
    GFToast.showToast(
      text,
      context,
      toastPosition: _toastPosition,
      trailing: const Icon(
        Icons.done,
        color: GFColors.SUCCESS,
        size: _toastIconSize,
      ),
      toastBorderRadius: _toastRadius,
    );
  }
}
