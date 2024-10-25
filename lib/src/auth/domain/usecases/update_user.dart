import 'package:equatable/equatable.dart';
import 'package:air_guard/core/enums/update_enums.dart';
import 'package:air_guard/core/usecases/usecases.dart';
import 'package:air_guard/core/utils/typedefs.dart';
import 'package:air_guard/src/auth/domain/repositories/auth_repo.dart';

class UpdateUser implements FutureUsecaseWithParams<void, UpdateUserParams> {
  const UpdateUser(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call(UpdateUserParams params) => _repository.updateUser(
        action: params.action,
        userData: params.userData,
      );
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({
    required this.action,
    required this.userData,
  });

  const UpdateUserParams.empty()
      : this(action: UpdateUserAction.fullName, userData: '');

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<Object?> get props => [action, userData];
}
