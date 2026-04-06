import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStarted extends AuthEvent {}
class AuthLoggedIn extends AuthEvent {
  final UserEntity user;
  const AuthLoggedIn({required this.user});
  @override
  List<Object?> get props => [user];
}
class AuthLoggedOut extends AuthEvent {}
class AuthDeleted extends AuthEvent {}

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthAuthenticated extends AuthState {
  final UserEntity user;
  const AuthAuthenticated({required this.user});
  @override
  List<Object?> get props => [user];
}
class AuthUnauthenticated extends AuthState {}


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<AuthStarted>(_onAuthStarted);
    on<AuthLoggedIn>(_onAuthLoggedIn);
    on<AuthLoggedOut>(_onAuthLoggedOut);
    on<AuthDeleted>(_onAuthDeleted);
  }

  void _onAuthStarted(AuthStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await emit.forEach<UserEntity?>(
      _authRepository.user,
      onData: (user) => (user != null) ? AuthAuthenticated(user: user) : AuthUnauthenticated(),
    );
  }

  void _onAuthLoggedIn(AuthLoggedIn event, Emitter<AuthState> emit) {
    emit(AuthAuthenticated(user: event.user));
  }

  void _onAuthLoggedOut(AuthLoggedOut event, Emitter<AuthState> emit) async {
    await _authRepository.signOut();
    emit(AuthUnauthenticated());
  }

  void _onAuthDeleted(AuthDeleted event, Emitter<AuthState> emit) async {
    await _authRepository.deleteAccount();
    emit(AuthUnauthenticated());
  }
}
