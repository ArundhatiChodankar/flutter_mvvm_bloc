part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String? email;
  final String? password;
  const LoginState({this.email='', this.password=''});

  LoginState copyWith({String? email, String? password}){
    return LoginState(email: email,password: password);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [email,password];

}

