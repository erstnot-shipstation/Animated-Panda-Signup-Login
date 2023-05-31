import 'package:flutter/material.dart';

import '../common_widgets/appbars.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: justBackButtonWithTitleAppBar(context, "Terms of use"),
      body: const Center(
        child: Text("Terms of use"),
      ),
    );
  }
}
