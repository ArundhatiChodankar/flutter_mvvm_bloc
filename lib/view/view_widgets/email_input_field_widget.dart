import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc/view_model/login_bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../res/strings/app_strings.dart';
import '../../utils/utils.dart';
import 'package:email_validator/email_validator.dart';

class EmailInputFieldWidget extends StatelessWidget {
  final TextEditingController emailController;
  final FocusNode currentFocusNode;
  final FocusNode nextFocusNode;

  const EmailInputFieldWidget(
      this.emailController,
      this.currentFocusNode,
      this.nextFocusNode, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          controller: emailController,
          focusNode: currentFocusNode,
          keyboardType: TextInputType.emailAddress,
          validator: (value) => _validateEmail(value, context),
          onFieldSubmitted: (value) => _onFieldSubmitted(context),
          onChanged: (value) => context.read<LoginBloc>().add(EmailChangedEvent(email: value)),
          decoration: _inputDecoration(),
        );
      },
    );
  }

  String? _validateEmail(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailEmptyError;
    } else if (!EmailValidator.validate(value)) {
      return AppStrings.emailInvalidError;
    }
    return null;
  }

  void _onFieldSubmitted(BuildContext context) {
    Utils.changeNodeFocus(context, current: currentFocusNode, next: nextFocusNode);
  }

  InputDecoration _inputDecoration() {
    return const InputDecoration(
      prefixIcon: Icon(Icons.email),
      labelText: AppStrings.email,
      hintText: 'abc@gmail.com',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
