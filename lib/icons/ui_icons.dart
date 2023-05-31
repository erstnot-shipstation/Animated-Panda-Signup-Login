import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../assets_db/assets_db.dart';
import '../utils/utils.dart';

class UiIcons {
  UiIcons._();
  static IconButton icon(String asset,
      {double size = 24.0,
      Color? color = Colors.black,
      Function onPressed = Utils.emptyFunction}) {
    return IconButton(
      onPressed: () {
        onPressed();
      },
      padding: EdgeInsets.zero,
      icon: SvgPicture.asset(
        asset,
        color: color,
        width: size,
        height: size,
      ),
    );
  }

  static IconButton home(
      {double size = 24.0,
      Color? color = Colors.black,
      Function onPressed = Utils.emptyFunction}) {
    return icon(
      AssetsDb.homeIcon,
      size: size,
      color: color,
      onPressed: onPressed,
    );
  }

  static IconButton phone(
      {double size = 24.0,
      Color? color = Colors.black,
      Function onPressed = Utils.emptyFunction}) {
    return icon(
      AssetsDb.phoneIcon,
      size: size,
      color: color,
      onPressed: onPressed,
    );
  }

  static IconButton person(
      {double size = 24.0,
      Color? color = Colors.black,
      Function onPressed = Utils.emptyFunction}) {
    return icon(
      AssetsDb.userIcon,
      size: size,
      color: color,
      onPressed: onPressed,
    );
  }

  static IconButton back(
      {double size = 24.0,
      Color? color = Colors.black,
      Function onPressed = Utils.emptyFunction}) {
    return icon(
      AssetsDb.backIcon,
      size: size,
      color: color,
      onPressed: onPressed,
    );
  }
}
