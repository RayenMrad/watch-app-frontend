import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:clean_arch/domain/repository/command_reposetory.dart';
import 'package:dartz/dartz.dart';

class CreateCommandUsecase {
  final CommandRepository _commandRepository;

  const CreateCommandUsecase(this._commandRepository);

  Future<Either<Failure, Unit>> call(
          {required String userId, required List<Sales> sales}) async =>
      _commandRepository.createCommand(userId: userId, sales: sales);
}
