import 'package:flutter/material.dart';

import '../../icons/ui_icons.dart';
import '../../routes/navigator/inapp_navigation.dart';

AppBar justBackButtonAppBar(BuildContext context) {
  return AppBar(
    leading: UiIcons.back(
        color: Theme.of(context).colorScheme.primary,
        onPressed: () {
          InAppNavigation.pop(context);
        }),
  );
}

AppBar justBackButtonWithTitleAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
    centerTitle: true,
    leading: UiIcons.back(
      color: Theme.of(context).colorScheme.primary,
      onPressed: () {
        InAppNavigation.pop(context);
      },
    ),
  );
}
