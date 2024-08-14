import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final bool loading;

  const RoundButton({
    super.key,
    required this.title,
    required this.onPress,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onPress, // Prevent tapping when loading
      child: Ink(
        height: 50,
        width: double.infinity, // Make button responsive
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: loading ? AppColors.disabledButtonColor : AppColors.buttonColor, // Disable color
        ),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(
            color: Colors.black,
          )
              : Text(
            title,
            style: TextStyle(color: AppColors.whiteColor),
          ),
        ),
      ),
    );
  }
}
