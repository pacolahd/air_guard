import 'package:air_guard/core/usecases/usecases.dart';
import 'package:air_guard/core/utils/typedefs.dart';
import 'package:air_guard/src/on_boarding/domain/repos/on_boarding_repo.dart';

class CheckIfUserIsFirstTimer extends FutureUsecaseWithoutParams<bool> {
  const CheckIfUserIsFirstTimer(this._repo);

  final OnBoardingRepo _repo;

  @override
  ResultFuture<bool> call() => _repo.checkIfUserIsFirstTimer();
}
