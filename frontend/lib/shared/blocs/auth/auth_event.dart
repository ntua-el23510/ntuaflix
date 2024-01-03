part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent({this.onError, this.onSuccess, this.formKey});
  final VoidCallback? onSuccess;
  final ValueChanged? onError;
  final GlobalKey<FormBuilderState>? formKey;
}

class Register extends AuthEvent {
  const Register({
    required this.nickname,
    required this.email,
    required this.password,
    super.onSuccess,
    super.onError,
    super.formKey,
  });
  final String nickname;
  final String email;
  final String password;
}

class Login extends AuthEvent {
  const Login({
    required this.email,
    required this.password,
    super.onSuccess,
    super.onError,
    super.formKey,
  });
  final String email;
  final String password;
}

class Logout extends AuthEvent {}
