import 'package:flutter/material.dart';

import '../../res/strings/app_strings.dart';
import '../../res/widgets/round_button.dart';
import '../../utils/utils.dart';

class LoginButtonWidget extends StatelessWidget {
  final formkey;

  const LoginButtonWidget({required this.formkey, super.key});

  @override
  Widget build(BuildContext context) {
    return RoundButton(
        title: AppStrings.login,
        loading: false,
        onPress: () {
          if (formkey.currentState!.validate()) {
            print('LoginButtonWidget.build login ');
          }
        });
  }
}
