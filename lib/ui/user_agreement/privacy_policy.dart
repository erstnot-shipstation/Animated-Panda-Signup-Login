import 'package:flutter/material.dart';

import '../common_widgets/appbars.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: justBackButtonWithTitleAppBar(context, "Privacy Policy"),
      body: const Center(
        child: Text("Privacy Policy"),
      ),
    );
  }
}
