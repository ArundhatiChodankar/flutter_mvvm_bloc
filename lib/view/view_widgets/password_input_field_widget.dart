import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_bloc/view_model/login_bloc/login_bloc.dart';

import '../../res/strings/app_strings.dart';
import '../../utils/utils.dart';

class PasswordInputFieldWidget extends StatefulWidget {

  final TextEditingController? passwordController;
  final FocusNode? currentFocusNode;
  final FocusNode? nextFocusNode;

  const PasswordInputFieldWidget(
      {this.passwordController, this.currentFocusNode, this.nextFocusNode,
        super.key});


  @override
  State<PasswordInputFieldWidget> createState() =>
      _PasswordInputFieldWidgetState();
}

class _PasswordInputFieldWidgetState extends State<PasswordInputFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          controller: widget.passwordController,
          focusNode: widget.currentFocusNode,
          obscureText: true,
          obscuringCharacter: "*",
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline),
            label: const Text(AppStrings.password),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onChanged: (value){

              context.read<LoginBloc>().add(PasswordChangedEvent(password: value));

          },
          validator: ((value) {
            if (value!.isEmpty) {
              Utils.snackBar(AppStrings.passwordEmptyError, context);
              return AppStrings.passwordEmptyError;
            }else if (value.length<6) {
              Utils.snackBar(AppStrings.passwordLengthError, context);
              return AppStrings.passwordLengthError;
            }
            return null;
          }),
        );
      },
    );
  }
}
