import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm_bloc/data/status.dart';
import 'package:flutter_mvvm_bloc/repository/auth/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository loginRepository = LoginRepository();
  LoginBloc() : super(const LoginState()) {
    on<EmailChangedEvent>((event, emit) {
      emit(state.copyWith(email:event.email));
    });
    on<PasswordChangedEvent>((event, emit) {
      emit(state.copyWith(password:event.password));
    });

    on<LoginApiEvent>((event, emit) async{
      Map data={'email':state.email, 'password':state.password};
      emit(state.copyWith(status: PostStatus.loading));
      try {
        final value = await loginRepository.loginApi(data);
        print('LoginBloc.LoginBloc='+value.toString());
        if (kDebugMode) {
          print('value=$value');
        }

        if (value.error != null && value.error!.isNotEmpty) {
          emit(state.copyWith(status: PostStatus.error, message: value.error.toString()));
        } else {
          emit(state.copyWith(status: PostStatus.success, message: 'Login Successful'));
        }
      } catch (error) {
        print('LoginBloc.LoginBloc='+error.toString());
        emit(state.copyWith(status: PostStatus.error, message: error.toString()));
      }
    });

  }
}
