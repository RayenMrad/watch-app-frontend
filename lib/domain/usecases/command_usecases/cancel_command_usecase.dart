import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/repository/command_reposetory.dart';
import 'package:dartz/dartz.dart';

class CancelCommandUsecase {
  final CommandRepository _commandRepository;

  const CancelCommandUsecase(this._commandRepository);

  Future<Either<Failure, Unit>> call({required String commandId}) async =>
      _commandRepository.cancelCommand(commandId: commandId);
}
