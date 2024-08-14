import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm_bloc/data/status.dart';
import 'package:flutter_mvvm_bloc/repository/auth/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  // Constructor with dependency injection
  LoginBloc({required this.loginRepository}) : super(const LoginState()) {
    on<EmailChangedEvent>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<PasswordChangedEvent>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<LoginApiEvent>((event, emit) async {
      final data = {
        'email': state.email,
        'password': state.password,
      };

      emit(state.copyWith(status: PostStatus.loading));

      try {
        final value = await loginRepository.loginApi(data);
        if (kDebugMode) {
          print('Login API response: $value');
        }

        if (value.error?.isNotEmpty ?? false) {
          emit(state.copyWith(
              status: PostStatus.error, message: value.error.toString()));
        } else {
          emit(state.copyWith(
              status: PostStatus.success, message: 'Login Successful'));
        }
      } catch (error) {
        if (kDebugMode) {
          print('Login API error: $error');
        }
        emit(state.copyWith(
            status: PostStatus.error, message: error.toString()));
      }
    });
  }
}
