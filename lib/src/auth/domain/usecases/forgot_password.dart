import 'package:air_guard/core/usecases/usecases.dart';
import 'package:air_guard/core/utils/typedefs.dart';
import 'package:air_guard/src/auth/domain/repositories/auth_repo.dart';

class ForgotPassword implements FutureUsecaseWithParams<void, String> {
  const ForgotPassword(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call(String email) => _repository.forgotPassword(email);
}
