import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../ui/home/home.dart';
import '../../ui/profile/profile.dart';
import '../../ui/signup/otp.dart';
import '../../ui/signup/signup.dart';
import '../../ui/user_agreement/privacy_policy.dart';
import '../../ui/user_agreement/terms_of_user.dart';
import '../routes.dart';

class InAppNavigation {
  InAppNavigation._();

  static void _push(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      PageTransition(
        child: screen,
        type: PageTransitionType.fade,
        curve: Curves.easeIn,
        alignment: Alignment.center,
      ),
    );
  }

  static void pushReplacement(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      PageTransition(
        child: screen,
        type: PageTransitionType.fade,
        curve: Curves.easeIn,
        alignment: Alignment.center,
      ),
    );
  }

  static void _popAndPush(BuildContext context, String screen) {
    Navigator.popAndPushNamed(context, screen);
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  //HOME
  static void home(BuildContext context) {
    _push(context, const HomeScreen());
  }

  static void popAndPushHome(BuildContext context) {
    _popAndPush(context, Routes.home);
  }

  //OTP
  static void otp(BuildContext context) {
    _push(context, const OtpScreen());
  }

  //Profile
  static void signup(BuildContext context) {
    _push(context, const SignupScreen());
  }

  static void profile(BuildContext context) {
    _push(context, const ProfileScreen());
  }

  //Privacy policy
  static void privacyPolicy(BuildContext context) {
    _push(context, const PrivacyPolicyScreen());
  }

  //Terms of use
  static void termsOfUse(BuildContext context) {
    _push(context, const TermsOfUseScreen());
  }
}
