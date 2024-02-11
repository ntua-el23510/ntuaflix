part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState(this.user);
  final User? user;
}

final class Unauthorized extends AuthState with EquatableMixin {
  const Unauthorized() : super(null);

  @override
  List<Object> get props => [1];
}

final class Authorized extends AuthState with EquatableMixin {
  const Authorized(super.user);

  @override
  List<Object> get props => [Random().nextInt(100)];
}
