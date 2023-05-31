import 'package:boilerplate_code/global_constants/global_constants.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Utils {
  Utils._();

  static void emptyFunction() {}
  static void emptyFunctionWithInt(int value) {}
  static void emptyFunctionWithString(String value) {}
  static Widget verticalSpace(double value) {
    return SizedBox(
      height: 8 * value,
    );
  }

  static Widget horizontalSpace(double value) {
    return SizedBox(
      width: 8 * value,
    );
  }

  static double spaceScale(double value) {
    return 8 * value;
  }

  static Widget verticalSizedBox(double value) {
    return SizedBox(
      height: value,
    );
  }

  static Widget horizontalSizedBox(double value) {
    return SizedBox(
      width: value,
    );
  }

  static String getNewUuid() {
    return const Uuid().v1();
  }

  static DateTime timeNow() {
    return DateTime.now();
  }

  static String convertTimeToString(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.year.toString()}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }

  static String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  static Widget elevatedActionButtonWithIcon(
    BuildContext context,
    String buttonText, {
    Color buttonColor = const Color(0xff0f5dfb),
    IconData? iconData,
    onClick = emptyFunction,
  }) {
    return ElevatedButton(
      onPressed: () {
        onClick();
      },
      // style: NeumorphicStyle(
      //     depth: GlobalConstants.neumorphicDepth,
      //     intensity: GlobalConstants.neumorphicIntensity,
      //     surfaceIntensity: GlobalConstants.neumorphicSurfaceIntensity,
      //     color: buttonColor,
      //     boxShape: NeumorphicBoxShape.roundRect(
      //       BorderRadius.circular(GlobalConstants.edgeRadius),
      //     )),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        enableFeedback: true,
        backgroundColor: buttonColor,
        elevation: 5,
        animationDuration: const Duration(milliseconds: 500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(GlobalConstants.edgeRadius),
        ),
      ),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: buttonText,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (iconData != null)
                WidgetSpan(
                    child: Icon(
                  iconData,
                  color: Colors.white,
                  size: 20,
                ))
            ],
          ),
        ),
      ),
    );
  }

  static Widget circularTimerClock(
    CountDownController controller,
    int duration,
    double width,
    double height,
    double strokeWidth,
    Color fillColor, {
    Function onStart = emptyFunction,
    Function onComplete = emptyFunction,
    Function onChange = emptyFunction,
  }) {
    return CircularCountDownTimer(
      width: width,
      height: height,

      // Countdown duration in Seconds.
      duration: duration,

      // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
      controller: controller,

      // Width of the Countdown Widget.

      // Height of the Countdown Widget.

      // Ring Color for Countdown Widget.
      ringColor: Colors.grey[300]!,

      // Ring Gradient for Countdown Widget.
      ringGradient: null,

      // Filling Color for Countdown Widget.
      fillColor: fillColor,

      // Filling Gradient for Countdown Widget.
      fillGradient: null,

      // Background Color for Countdown Widget.
      // backgroundColor: const Color(0xffe7d8fd),

      // Background Gradient for Countdown Widget.
      backgroundGradient: null,

      // Border Thickness of the Countdown Ring.
      strokeWidth: strokeWidth,

      // Begin and end contours with a flat edge and no extension.
      strokeCap: StrokeCap.round,

      // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
      isReverse: true,
      isTimerTextShown: false,
      // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
      isReverseAnimation: true,

      // Handles visibility of the Countdown Text.

      // Handles the timer start.
      autoStart: true,

      // This Callback will execute when the Countdown Ends.
      onComplete: () {
        onComplete();
      },

      // This Callback will execute when the Countdown Changes.
      onChange: (String timeStamp) {
        // Here, do whatever you want
      },
    );
  }

  static OutlineInputBorder outlineInputBorder(
      double circularBorderRadius, Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(circularBorderRadius),
      ),
      borderSide: BorderSide(color: borderColor),
    );
  }
}
