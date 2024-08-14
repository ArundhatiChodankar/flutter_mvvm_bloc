import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_bloc/view_model/login_bloc/login_bloc.dart';

import '../../res/strings/app_strings.dart';

class PasswordInputFieldWidget extends StatefulWidget {
  final TextEditingController? passwordController;
  final FocusNode? currentFocusNode;
  final FocusNode? nextFocusNode;

  const PasswordInputFieldWidget({
    this.passwordController,
    this.currentFocusNode,
    this.nextFocusNode,
    super.key,
  });

  @override
  PasswordInputFieldWidgetState createState() => PasswordInputFieldWidgetState();
}

class PasswordInputFieldWidgetState extends State<PasswordInputFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          controller: widget.passwordController,
          focusNode: widget.currentFocusNode,
          obscureText: true,
          obscuringCharacter: "*",
          decoration: _inputDecoration(),
          onChanged: (value) {
            context.read<LoginBloc>().add(PasswordChangedEvent(password: value));
          },
          validator: (value) => _validatePassword(value, context),
        );
      },
    );
  }

  InputDecoration _inputDecoration() {
    return const InputDecoration(
      prefixIcon: Icon(Icons.lock_outline),
      labelText: AppStrings.password,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  String? _validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordEmptyError;
    } else if (value.length < 6) {
      return AppStrings.passwordLengthError;
    }
    return null;
  }
}
