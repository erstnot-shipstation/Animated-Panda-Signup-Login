import 'package:boilerplate_code/routes/navigator/inapp_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../../assets_db/assets_db.dart';
import '../../models/enums.dart';
import '../../models/profile.dart';
import '../../routes/routes.dart';
import '../../stores/profile/profile.dart';
import '../../utils/utils.dart';
import '../common_widgets/toast/inapp_toast.dart';
import '../user_agreement/user_agreement.dart';
import 'forms/signup_form_constants.dart';
import 'forms/signup_form_name_field.dart';
import 'forms/signup_form_phone_field.dart';

// ignore: constant_identifier_names

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenInputState();
}

class _SignupScreenInputState extends State<SignupScreen> {
  SMIBool? _isChecking;
  SMIBool? _isHandsUp;
  late ProfileStore _profileStore;

  SubmitState _submitState = SubmitState.NOTTOUCHED;

  // ignore: unused_field
  SMITrigger? _trigFailure;
  SMITrigger? _trigSuccess;
  final _userNameKey = GlobalKey<FormBuilderState>();
  bool keyboardVisible = false;
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _phoneTextEditingController =
      TextEditingController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _profileStore = Provider.of<ProfileStore>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameTextEditingController.dispose();
    _phoneTextEditingController.dispose();
  }

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      keyboardVisible = visible;
      setState(() {});
    });
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

  Widget _bottomNavigationButtonLoader() {
    return Visibility(
      visible: _submitState == SubmitState.STARTED,
      child: LinearProgressIndicator(
        minHeight: MediaQuery.of(context).size.height * 0.005,
        color: Colors.blue,
      ),
    );
  }

  Widget _profileInputForm() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: FormBuilder(
          key: _userNameKey,
          child: Column(
            children: [
              SignupFormNameField(
                textEditingController: _nameTextEditingController,
                onChanged: onFormInputChange,
              ),
              Utils.verticalSpace(1),
              SignupFormPhoneField(
                textEditingController: _phoneTextEditingController,
                onChanged: onFormInputChange,
              ),
            ],
          )),
    );
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

  Widget _getStartedText() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
            text: "Get Started!\n",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
            ),
            children: [
              TextSpan(
                text: "Enter your phone number to get started\n",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.w300,
                  fontSize: Theme.of(context).textTheme.labelSmall?.fontSize,
                ),
              )
            ]),
      ),
    );
  }

  onSignupComplete(String username, String phone) async {
    await _profileStore
        .setProfileData(ProfileModel(name: username, phoneNumber: phone));
    setState(() {
      _submitState = SubmitState.DONE;
    });
    // ignore: use_build_context_synchronously
    InAppToast.otpSendSuccess(context);
    InAppNavigation.otp(context);
  }

  onSignupError(String username, String phone) async {
    InAppToast.errorSendingOtp(context);
    _isHandsUp?.change(true);
    setState(() {
      _submitState = SubmitState.ERROR;
    });
  }

  onContinueButtonPressed() async {
    if (_userNameKey.currentState!.validate()) {
      _isHandsUp?.change(false);
      setState(() {
        _submitState = SubmitState.STARTED;
      });
      _userNameKey.currentState!.save();
      String username = _userNameKey
          .currentState!.value[ProfileFormConstants.name]
          .toString();

      String phone = _userNameKey
          .currentState!.value[ProfileFormConstants.phone]
          .toString();
      phone = ProfileFormConstants.countryCode + phone;

      _trigSuccess?.fire();
      await onSignupComplete(username, phone);
    } else {
      _isHandsUp?.change(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Utils.logoWidget(),
        backgroundColor: const Color(0xFFd6e2ea),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: _bottomNavigationButtonLoader(),
        ),
      ),
      backgroundColor: const Color(0xFFd6e2ea),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: _animatedLoginScreen(),
          ),
          Visibility(visible: !keyboardVisible, child: Utils.verticalSpace(2)),
          Visibility(
            visible: !keyboardVisible,
            child: Expanded(
              flex: 1,
              child: _getStartedText(),
            ),
          ),
          Visibility(visible: !keyboardVisible, child: Utils.verticalSpace(2)),
          Expanded(
            flex: 3,
            child: _profileInputForm(),
          ),
          Visibility(
            visible: !keyboardVisible,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Utils.elevatedActionButtonWithIcon(
                context,
                "Login ",
                iconData: Icons.double_arrow_rounded,
                buttonColor: Theme.of(context).primaryColor,
                onClick: onContinueButtonPressed,
              ),
            ),
          ),
          Visibility(visible: !keyboardVisible, child: Utils.verticalSpace(2)),
          Visibility(
            visible: !keyboardVisible,
            child: const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: UserAgreement(),
            ),
          ),
        ],
      ),
    );
  }
}
