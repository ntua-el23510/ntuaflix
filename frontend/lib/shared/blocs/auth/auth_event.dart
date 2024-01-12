part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent({this.onError, this.onSuccess, this.formKey});
  final VoidCallback? onSuccess;
  final ValueChanged? onError;
  final GlobalKey<FormBuilderState>? formKey;
}

class Register extends AuthEvent with EquatableMixin {
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

  @override
  List<Object?> get props => [nickname, email, password];
}

class Login extends AuthEvent with EquatableMixin {
  const Login({
    required this.email,
    required this.password,
    super.onSuccess,
    super.onError,
    super.formKey,
  });
  final String email;
  final String password;
  @override
  List<Object?> get props => [email, password];
}

class UpdateUser extends AuthEvent with EquatableMixin {
  const UpdateUser({
    required this.user,
    super.onSuccess,
    super.onError,
    super.formKey,
  });
  final User user;
  @override
  List<Object?> get props => [Random().nextInt(100)];
}

class Logout extends AuthEvent {}
