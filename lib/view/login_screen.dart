import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mvvm_bloc/data/status.dart';
import 'package:flutter_mvvm_bloc/repository/auth/login_repository.dart';
import 'package:flutter_mvvm_bloc/view/view_widgets/email_input_field_widget.dart';
import 'package:flutter_mvvm_bloc/view/view_widgets/password_input_field_widget.dart';
import 'package:flutter_mvvm_bloc/view_model/login_bloc/login_bloc.dart';

import '../res/strings/app_strings.dart';
import '../res/widgets/spacing.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import 'view_widgets/login_button_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(loginRepository: LoginRepository()),
      child: BlocListener<LoginBloc, LoginState>(
        listenWhen: (current, previous) => current.status != previous.status,
        listener: (context, state) {
          switch (state.status) {
            case PostStatus.loading:
              Utils.toastMessage("Please wait");
              break;
            case PostStatus.success:
              Utils.toastMessage(state.message.toString());
              break;
            case PostStatus.error:
              Utils.toastMessage(state.message.toString());
              break;
            default:
              break;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.login),
            backgroundColor: Colors.pink,
            centerTitle: true,
          ),
          body: const _LoginForm(),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            EmailInputFieldWidget(
              _emailController,
              _emailFocus,
              _passwordFocus,
            ),
            const VerticalSpace(25),
            PasswordInputFieldWidget(
              passwordController: _passwordController,
              currentFocusNode: _passwordFocus,
              nextFocusNode: null,
            ),
            const VerticalSpace(50),
            LoginButtonWidget(formKey: _formKey),
            const VerticalSpace(50),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.signup);
              },
              child: Text(AppStrings.signUpLink),
            ),
          ],
        ),
      ),
    );
  }
}
