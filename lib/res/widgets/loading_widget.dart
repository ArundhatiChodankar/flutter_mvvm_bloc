import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc/res/colors/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final double size;
  const LoadingWidget({super.key, this.size = 60});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Platform.isAndroid
          ? CircularProgressIndicator(
        color: AppColors.primaryColor,
      )
          : CupertinoActivityIndicator(
        color: AppColors.primaryColor,
      ),
    );
  }
}

