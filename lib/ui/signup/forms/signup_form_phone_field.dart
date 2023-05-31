import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../icons/ui_icons.dart';
import '../../../utils/utils.dart';
import 'signup_form_constants.dart';

class SignupFormPhoneField extends StatelessWidget {
  const SignupFormPhoneField({
    super.key,
    required this.onChanged,
    required this.textEditingController,
  });
  final Function onChanged;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: ProfileFormConstants.phone,
      controller: textEditingController,
      maxLength: 10,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      onChanged: (value) {
        onChanged();
      },
      cursorColor: Colors.black,
      textAlign: TextAlign.justify,
      // keyboardType: TextInputType.number,
      keyboardType: const TextInputType.numberWithOptions(
        signed: true,
        decimal: true,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        focusedBorder:
            Utils.outlineInputBorder(10, Theme.of(context).primaryColor),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8),
          child: UiIcons.phone(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        labelText: "Phone number",
        labelStyle: const TextStyle(
          color: Colors.black26,
        ),
        enabledBorder: Utils.outlineInputBorder(10, Colors.white),
        errorBorder: Utils.outlineInputBorder(10, Colors.red),
        focusedErrorBorder:
            Utils.outlineInputBorder(10, Theme.of(context).primaryColor),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(10),
        FormBuilderValidators.minLength(10),
      ]),
    );
  }
}
