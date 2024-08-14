import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc/res/strings/app_strings.dart';

import '../colors/app_colors.dart';
import 'round_button.dart';

class InternetExceptionWidget extends StatefulWidget {
  final VoidCallback onPress;
  const InternetExceptionWidget({super.key, required this.onPress});

  @override
  State<InternetExceptionWidget> createState() => _InternetExceptionWidgetState();
}

class _InternetExceptionWidgetState extends State<InternetExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.cloud_off_rounded, color: Colors.red, size: 50),
        const SizedBox(height: 50),
        Center(
          child: Text(
            AppStrings.noInternetMessage,
            style: TextStyle(color: AppColors.blackColor),
          ),
        ),
        const SizedBox(height: 50),
        RoundButton(
          title: AppStrings.retry,
          onPress: () {
            widget.onPress(); // Call the onPress function
          },
        ),
      ],
    );
  }
}

