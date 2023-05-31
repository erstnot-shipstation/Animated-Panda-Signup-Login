import 'package:boilerplate_code/ui/common_widgets/appbars.dart';
import 'package:boilerplate_code/ui/common_widgets/toast/inapp_toast.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../../assets_db/assets_db.dart';
import '../../icons/ui_icons.dart';
import '../../models/enums.dart';
import '../../routes/navigator/inapp_navigation.dart';
import '../../stores/profile/profile.dart';
import '../../utils/utils.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final controller = TextEditingController();
  final _countDownController = CountDownController();
  late ProfileStore _profileStore;

  final focusNode = FocusNode();
  bool keyboardVisible = false;
  int secondsRemaining = 30;
  bool enableResend = false;

  SMIBool? _isChecking;
  SMIBool? _isHandsUp;

  SubmitState _submitState = SubmitState.NOTTOUCHED;

  // ignore: unused_field
  SMITrigger? _trigFailure;
  SMITrigger? _trigSuccess;

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      keyboardVisible = visible;
      if (visible) onFormInputChange();
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    _profileStore = Provider.of<ProfileStore>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'Login Machine');
    artboard.addController(controller!);
    _isChecking = controller.findInput<bool>('isChecking') as SMIBool;
    _isHandsUp = controller.findInput<bool>('isHandsUp') as SMIBool;
    _trigSuccess = controller.findInput<bool>('trigSuccess') as SMITrigger;
    _trigFailure = controller.findInput<bool>('trigFail') as SMITrigger;
    // controller.dispose();
  }

  void onFormInputChange() {
    _isHandsUp?.change(false);
    _isChecking?.change(true);
  }

  Widget _animatedLoginScreen() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: RiveAnimation.asset(
        AssetsDb.animatedLoginScreen,
        fit: BoxFit.contain,
        onInit: _onRiveInit,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFd6e2ea),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: UiIcons.back(
          color: Theme.of(context).colorScheme.primary,
          onPressed: () {
            InAppNavigation.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _bottomNavigationButtonLoader(),
          Expanded(
            flex: 4,
            child: _animatedLoginScreen(),
          ),
          Utils.verticalSpace(4),
          Visibility(
            visible: !keyboardVisible,
            child: Expanded(
                flex: 1,
                child:
                    _otpDescription(_profileStore.profile?.phoneNumber ?? "")),
          ),
          _otpBoxes(),
          Visibility(
            visible: !keyboardVisible,
            maintainState: true,
            child: _otpResend(),
          )
        ],
      ),
    );
  }

  Widget _otpDescription(String phoneNumber) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          text: _submitState != SubmitState.ERROR
              ? "Enter OTP \n"
              : "Wrong OTP \n",
          style: TextStyle(
            color: _submitState != SubmitState.ERROR
                ? Theme.of(context).primaryColor
                : Theme.of(context).errorColor,
            fontSize: Theme.of(context).textTheme.headline5?.fontSize,
          ),
          children: [
            WidgetSpan(
              child: Utils.verticalSpace(3),
            ),
            TextSpan(
              text: "A 4 digit code has been sent to\n $phoneNumber",
              style: const TextStyle(color: Colors.black, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }

  void _resendOtpCountDownEnd() {
    setState(() {
      enableResend = true;
    });
    _countDownController.reset();
  }

  Widget _otpResend() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              if (enableResend) {
                setState(() {
                  enableResend = false;
                });
                _countDownController.start();

                InAppToast.otpSendSuccess(context);
              }
            },
            child: Text(
              "Resend OTP",
              style: TextStyle(
                color: enableResend ? const Color(0xff0f5dfb) : Colors.grey,
              ),
            ),
          ),
          Utils.circularTimerClock(
            _countDownController,
            30,
            12,
            12,
            2,
            Theme.of(context).primaryColor,
            onComplete: _resendOtpCountDownEnd,
          )
        ],
      ),
    );
  }

  Widget _otpBoxes() {
    const length = 4;
    const borderColor = Color.fromRGBO(114, 178, 238, 1);
    const errorColor = Color.fromARGB(255, 255, 0, 47);
    const fillColor = Color.fromARGB(255, 255, 255, 255);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: GoogleFonts.poppins(
        fontSize: 22,
        color: const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return Center(
      child: SizedBox(
        height: 68,
        child: Pinput(
          length: length,
          controller: controller,
          focusNode: focusNode,
          defaultPinTheme: defaultPinTheme,
          onCompleted: (pin) {
            onContinueButtonPressed(pin);
          },
          focusedPinTheme: defaultPinTheme.copyWith(
            height: 68,
            width: 64,
            decoration: defaultPinTheme.decoration!.copyWith(
              border: Border.all(color: borderColor),
            ),
          ),
          errorPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!
                  .copyWith(border: Border.all(color: errorColor))),
          forceErrorState: _submitState == SubmitState.ERROR,
        ),
      ),
    );
  }

  Widget _bottomNavigationButtonLoader() {
    return Visibility(
      visible: _submitState == SubmitState.STARTED,
      child: LinearProgressIndicator(
        minHeight: MediaQuery.of(context).size.height * 0.005,
        color: Colors.blue,
      ),
    );
  }

  onContinueButtonPressed(String pin) async {
    setState(() {
      _submitState = SubmitState.STARTED;
    });
    final phoneNumber = _profileStore.profile?.phoneNumber;
    setState(() {
      _submitState = SubmitState.DONE;
    });
    InAppToast.otpVerificationSuccess(context);
    InAppNavigation.popAndPushHome(context);
  }
}
