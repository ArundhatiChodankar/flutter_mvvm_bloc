part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

// Triggered when the user changes the email input field.
class EmailChangedEvent extends LoginEvent {
  final String email;
  const EmailChangedEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

// Triggered when the user changes the password input field.
class PasswordChangedEvent extends LoginEvent {
  final String password;
  const PasswordChangedEvent({required this.password});

  @override
  List<Object?> get props => [password];
}

// Triggered when the user submits the login form.
class LoginApiEvent extends LoginEvent {
  const LoginApiEvent();

  @override
  List<Object?> get props => [];
}
