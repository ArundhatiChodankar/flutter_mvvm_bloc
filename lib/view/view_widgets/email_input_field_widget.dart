import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc/view_model/login_bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../res/strings/app_strings.dart';
import '../../utils/utils.dart';
import 'package:email_validator/email_validator.dart';

class EmailInputFieldWidget extends StatelessWidget {
  final TextEditingController _emailController;
  final FocusNode currentFocusNode;
  final FocusNode nextFocusNode;

  const EmailInputFieldWidget(
      this._emailController, this.currentFocusNode, this.nextFocusNode,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          controller: _emailController,
          focusNode: currentFocusNode,
          keyboardType: TextInputType.emailAddress,
          validator: ((value) {
            if (value!.isEmpty) {
              Utils.snackBar(AppStrings.emailEmptyError, context);
              return AppStrings.emailEmptyError;
            }
            else if (!EmailValidator.validate(value)) {
              Utils.snackBar(AppStrings.emailInvalidError, context);
              return AppStrings.emailInvalidError;
            }
            return null;
          }),
          onFieldSubmitted: (value) {
            Utils.changeNodeFocus(context,
                current: currentFocusNode, next: nextFocusNode);
          },
          onChanged: (value) {
            context.read<LoginBloc>().add(EmailChangedEvent(email: value));
          },
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.email),
            label: const Text(AppStrings.email),
            hintText: "abc@gmail.com",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}
