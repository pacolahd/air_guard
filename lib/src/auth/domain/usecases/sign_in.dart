import 'package:air_guard/core/usecases/usecases.dart';
import 'package:air_guard/core/utils/typedefs.dart';
import 'package:air_guard/src/auth/domain/entities/user_entity.dart';
import 'package:air_guard/src/auth/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';

class SignIn implements FutureUsecaseWithParams<UserEntity, SignInParams> {
  const SignIn(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<UserEntity> call(SignInParams params) => _repository.signIn(
        email: params.email,
        password: params.password,
      );
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });

  const SignInParams.empty()
      : email = '',
        password = '';

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
