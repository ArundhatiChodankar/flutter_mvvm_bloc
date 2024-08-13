import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_bloc/data/status.dart';
import 'package:flutter_mvvm_bloc/view_model/login_bloc/login_bloc.dart';

import '../../res/strings/app_strings.dart';
import '../../res/widgets/round_button.dart';

class LoginButtonWidget extends StatelessWidget {

  final GlobalKey<FormState> formKey;

  const LoginButtonWidget({ required this.formKey, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (current,previous)=>current.status!=previous.status,
      builder: (context, state) {
        return RoundButton(
            title: AppStrings.login,
            loading: state.status == PostStatus.loading ? true : false,
            onPress: () {
              if (formKey.currentState!.validate()) {
                context.read<LoginBloc>().add(const LoginApiEvent());
              }
            });
      },
    );
  }
}
